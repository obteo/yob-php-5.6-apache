FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

# Repository Sury PHP
RUN apt-get update && \
    apt-get install -y \
        wget \
        curl \
        gnupg2 \
        ca-certificates \
        lsb-release \
        apt-transport-https && \
    wget -O /tmp/php.gpg https://packages.sury.org/php/apt.gpg && \
    apt-key add /tmp/php.gpg && \
    echo "deb https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php.list

# Apache + PHP 5.6 + moduli necessari a XLRstats
RUN apt-get update && \
    apt-get install -y \
        apache2 \
        unzip \
        git \
        php5.6 \
        libapache2-mod-php5.6 \
        php5.6-cli \
        php5.6-common \
        php5.6-mysql \
        php5.6-curl \
        php5.6-gd \
        php5.6-json \
        php5.6-mbstring \
        php5.6-xml \
        php5.6-zip && \
    apt-get clean

# Rewrite richiesto da CakePHP
RUN a2enmod rewrite

# Utente Pterodactyl
RUN useradd -m -d /home/container -s /bin/bash container

# Directory applicazione
RUN mkdir -p /home/container/public_html && \
    mkdir -p /home/container/logs && \
    mkdir -p /home/container/status

# Apache punta a public_html
RUN sed -i 's#/var/www/html#/home/container/public_html#g' \
    /etc/apache2/sites-available/000-default.conf

# AllowOverride per .htaccess CakePHP
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' \
    /etc/apache2/apache2.conf

# Permessi
RUN chown -R www-data:www-data /home/container

WORKDIR /home/container

COPY --chmod=755 entrypoint.sh /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
