FROM node:14

WORKDIR /app

COPY package.json package-lock.json /app/
RUN npm install

COPY . /app/src

CMD ["node", "src/index.js"]
