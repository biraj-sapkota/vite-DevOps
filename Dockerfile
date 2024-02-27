FROM node:latest AS builder

WORKDIR /build

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build


FROM nginx:alpine AS production

WORKDIR /app

COPY --from=builder /build/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]