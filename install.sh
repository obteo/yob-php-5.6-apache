#!/bin/bash

cd /mnt/server

mkdir -p public_html
mkdir -p logs
mkdir -p status

wget -O xlrstats.zip \
https://github.com/XLRstats/xlrstats-web-v3/archive/refs/heads/master.zip

unzip -o xlrstats.zip

cp -R xlrstats-web-v3-master/* public_html/

rm -rf xlrstats.zip
rm -rf xlrstats-web-v3-master

chmod -R 775 public_html

echo "XLRstats installed."
