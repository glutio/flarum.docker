FROM composer:latest

# Install Nginx and other dependencies
RUN apk add --no-cache nginx supervisor

WORKDIR /var/www

RUN composer create-project flarum/flarum . && composer config repositories.domainsso path extensions/glutio/domainsso && composer require glutio/domainsso:* --ignore-platform-req=ext-fileinfo

COPY flarum/ .
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/supervisord.conf /etc/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
