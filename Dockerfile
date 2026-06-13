FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    wget curl gnupg2 ca-certificates lsb-release apt-transport-https

RUN wget -O /tmp/php.gpg https://packages.sury.org/php/apt.gpg && \
    apt-key add /tmp/php.gpg && \
    echo "deb https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php5.6 \
    libapache2-mod-php5.6 \
    php5.6-mysql \
    php5.6-gd \
    php5.6-curl \
    php5.6-mbstring \
    php5.6-xml \
    php5.6-zip \
    unzip \
    git

RUN a2enmod rewrite

RUN useradd -m -d /home/container -s /bin/bash container

RUN mkdir -p /home/container/public_html && \
    chown -R container:container /home/container

COPY --chown=container:container --chmod=755 entrypoint.sh /home/container/entrypoint.sh

WORKDIR /home/container

EXPOSE 80

CMD ["/home/container/entrypoint.sh"]
