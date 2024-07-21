#!/bin/sh

set -e

if [ -z $CERTBOT_DOMAIN ]; then
    echo "==> Warning: DOMAIN variable is null"
    exit 1
fi

if [ -z $CERTBOT_EMAIL ]; then
    echo "==> Warning: EMAIL variable is null"
    exit 1
fi

echo "==> Getting certificate for ${CERTBOT_DOMAIN}"

certbot --verbose certonly \
    --webroot \
    --webroot-path "/var/www/html/" \
    --domain "${CERTBOT_DOMAIN}" \
    --email "${CERTBOT_EMAIL}" \
    --rsa-key-size 4096 \
    --agree-tos \
    --non-interactive \
    --no-eff-email

# Check if DH params file exists, if not, generate it
if [ ! -f "/etc/letsencrypt/live/www.${CERTBOT_DOMAIN}/ssl-dhparams.pem" ]; then
    openssl dhparam -out /etc/letsencrypt/live/www.${CERTBOT_DOMAIN}/ssl-dhparams.pem 2048
fi
