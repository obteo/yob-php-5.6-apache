FROM php:5.6-apache

RUN apt-get update && \
    apt-get install -y \
        wget \
        unzip \
        git

RUN a2enmod rewrite

RUN mkdir -p /home/container/public_html

COPY --chmod=755 entrypoint.sh /entrypoint.sh

WORKDIR /home/container

CMD ["/entrypoint.sh"]
