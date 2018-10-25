# First step: Build with Node.js
FROM node:10.10.0-alpine as builder
WORKDIR /usr/src/app
ENV TZ = "Asia/Singapore"
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Deliver the dist folder with Nginx
FROM nginx:stable-alpine
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
COPY entrypoint.sh /

CMD ["/entrypoint.sh"]