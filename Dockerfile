FROM debian:11

LABEL maintainer="obteo"

ENV DEBIAN_FRONTEND=noninteractive

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

RUN apt-get update && \
    apt-get install -y \
        nginx \
        unzip \
        git \
        php5.6 \
        php5.6-fpm \
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

RUN useradd -m -d /home/container -s /bin/bash container

RUN mkdir -p /home/container/public_html && \
    mkdir -p /home/container/logs && \
    mkdir -p /home/container/status

COPY nginx.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /home/container

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
