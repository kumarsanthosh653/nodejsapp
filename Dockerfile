FROM node:19.0.0
WORKDIR /usr/src/app
COPY nodeapp/* /
RUN npm install
EXPOSE 3000
CMD [ "npm","start" ]
