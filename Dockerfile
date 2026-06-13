FROM php:5.6-apache

RUN apt-get update && apt-get install -y \
    unzip \
    wget \
    git \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    zlib1g-dev

RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
    mysqli \
    gd \
    zip

RUN a2enmod rewrite

RUN usermod -d /home/container www-data && \
    mkdir -p /home/container/public_html

COPY --chmod=755 entrypoint.sh /entrypoint.sh

WORKDIR /home/container

EXPOSE 80

CMD ["/entrypoint.sh"]
