#!/bin/bash

mkdir -p /home/container/public_html

exec apache2-foreground
