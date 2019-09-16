FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 2nd phase, copy /app/build from builder phase into /usr/share/nginx/html
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

#default port for nginx is 80
# docker run -p 8080:80 <image_id>