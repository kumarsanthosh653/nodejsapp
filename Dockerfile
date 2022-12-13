FROM node:19.0.1
WORKDIR /usr/src/app
COPY nodeapp/* /
RUN npm install
EXPOSE 3000
CMD [ "npm","start" ]
