# Use the Composer image to get Composer
FROM composer:latest as composer

# Now use the PHP image where your application will reside
FROM php:7.4-fpm-alpine

# Copy Composer from the Composer image
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install Nginx and Supervisor
RUN apk add --no-cache nginx supervisor

# Set the working directory for your Flarum application
WORKDIR /var/www/html

# Install Flarum and other dependencies via Composer
RUN composer create-project flarum/flarum . && \
    composer require glutio/domainsso:* --ignore-platform-req=ext-fileinfo

# Copy your Nginx and Supervisor configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/supervisord.conf /etc/supervisord.conf

# Copy your Flarum application files if needed
COPY --chown=www-data:www-data flarum/ .

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
