FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:stable-alpine as deploy-stage
COPY --from=build-stage /app/dist/deploy-angular-docker-multistage /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]