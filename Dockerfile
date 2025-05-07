FROM node:18 AS builder
WORKDIR /app
ARG VITE_CP_API_GATEWAY_URL
ENV VITE_CP_API_GATEWAY_URL=$VITE_CP_API_GATEWAY_URL
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]
