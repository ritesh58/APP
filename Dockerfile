FROM node:latest as builder

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json ./

RUN npm install

COPY . ./

RUN npm run build

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 3000 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]