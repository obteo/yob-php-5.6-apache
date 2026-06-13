#!/bin/bash

echo "Starting Apache PHP 5.6"

sed -i 's#/var/www/html#/home/container/public_html#g' \
    /etc/apache2/sites-available/000-default.conf

exec apachectl -D FOREGROUND
