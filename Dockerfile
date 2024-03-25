# Use the Composer image to get Composer
FROM composer:latest as composer

# Now use the PHP image where your application will reside
FROM php:fpm-alpine3.18

# Copy Composer from the Composer image
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install Nginx and Supervisor
RUN apk add --no-cache nginx supervisor

# Set the working directory for your Flarum application
RUN mkdir /var/www/flarum
WORKDIR /var/www/flarum

# Install Flarum and other dependencies via Composer
RUN composer create-project flarum/flarum . && \
    composer require ianm/log-viewer fof/oauth clarkwinkelmann/flarum-ext-passwordless isaced/flarum-ext-email-verification-switch

# gd dependencies
RUN apk add --no-cache \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        freetype-dev

# As of PHP 7.4 we don't need to add --with-png for gd
RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype
RUN docker-php-ext-install gd && \
    docker-php-ext-install pdo_mysql

# Copy your Nginx and Supervisor configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/supervisord.conf /etc/supervisord.conf

# Copy your Flarum application files if needed
COPY flarum/ .
RUN chown -R www-data:www-data /var/www/flarum

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
