FROM node:14-alpine

RUN \
    # NodeJS bundle
    apk add --no-cache nodejs npm apache2-utils && \
    npm install --global pm2 mocha

# App
ADD ./test/package.json ./test/package-lock.json /tmp/

RUN cd /tmp && \
    npm install

WORKDIR srv
ADD ./test /srv

RUN mv /tmp/node_modules /srv

CMD [ "npm", "run", "test" ]