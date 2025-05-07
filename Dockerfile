FROM node:18 AS builder
WORKDIR /app
ARG VITE_CP_API_GATEWAY_URL
ENV VITE_CP_API_GATEWAY_URL=$VITE_CP_API_GATEWAY_URL
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY entrypoint.sh /entrypoint.sh
COPY public/env.js /usr/share/nginx/html/env.js.template
RUN chmod +x /entrypoint.sh
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
