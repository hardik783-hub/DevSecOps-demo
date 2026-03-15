FROM node:20 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . . 

RUN npm run build

# stage2: serve with NGINX
FROM nginx:alpine
# Update alpine packages to fix vulnerabillities
RUN apk update && apk upgrade
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
