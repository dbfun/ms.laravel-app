FROM nginx:latest

RUN apt-get update && apt-get install -y curl

COPY ./docker/nginx/conf.d                  /etc/nginx/conf.d
COPY ./docker/nginx/docker-healthcheck.sh   /srv/docker-healthcheck.sh
COPY ./src /var/www

WORKDIR /var/www

EXPOSE 80

HEALTHCHECK --interval=60s --timeout=5s --start-period=5s CMD /srv/docker-healthcheck.sh

CMD ["nginx", "-g", "daemon off;"]
