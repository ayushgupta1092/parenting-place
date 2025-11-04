FROM node:18

WORKDIR /app

COPY package*.json ./
RUN apt-get update && apt-get install -y python3 make g++ \
  && npm install \
  && apt-get purge -y python3 make g++ \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

COPY . .

EXPOSE 5000
CMD ["npm", "start"]
