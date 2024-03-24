FROM php:7.4-fpm-alpine

# Install Nginx and other dependencies
RUN apk add --no-cache nginx supervisor

WORKDIR /var/www

COPY flarum/ .
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/supervisord.conf /etc/supervisord.conf

RUN composer create-project flarum/flarum . && composer require glutio/domainsso:* --ignore-platform-req=ext-fileinfo

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]