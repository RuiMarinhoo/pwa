FROM node:16-alpine as build

WORKDIR /app
COPY . .

RUN npm install --legacy-peer-deps
RUN npm run ng build --prod


FROM nginx:1.13.8-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/dist/pwa .
ENTRYPOINT ["nginx", "-g", "daemon off;"]

EXPOSE 80 443

