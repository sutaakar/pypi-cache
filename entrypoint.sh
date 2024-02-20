#!/bin/sh

openssl genrsa -out /etc/nginx/certs/cert.key 2048
openssl req -x509 -days 360 -new -key /etc/nginx/certs/cert.key -out /etc/nginx/certs/cert.crt -subj '/CN=devpi/O=RHOAI'

devpi-server --host=0.0.0.0 --serverdir /devpi &
nginx -g "daemon off;"

