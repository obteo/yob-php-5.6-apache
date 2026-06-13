#!/bin/bash

mkdir -p /home/container/public_html

chown -R www-data:www-data /home/container

exec apache2-foreground
