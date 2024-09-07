# Use the official PHP image with Apache
FROM php:8.3-apache
EXPOSE 80
# Mikhmon Version 3 or 4
ARG MIKHMON_VERSION=version-4


# Install necessary PHP extensions
RUN apt-get update && apt-get install -y \
    libonig-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    zlib1g-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install session \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip
	

# Add application
COPY ${MIKHMON_VERSION} /var/www/html/
# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
# Setup document root
WORKDIR /var/www/html