FROM node

RUN apt-get update -y && apt-get upgrade -y

WORKDIR /app

RUN npm install -g bun

COPY package*.json bun.lockb ./
RUN bun update

COPY . .

EXPOSE 3000

CMD ["bun","--watch", "run", "dev"]