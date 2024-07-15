#!/bin/sh

set -e

if [ -z $DOMAIN ]; then
    echo "==> Warning: DOMAIN variable is null"
    exit 1
fi

if [ -z $EMAIL ]; then
    echo "==> Warning: EMAIL variable is null"
    exit 1
fi

# until nc -z proxy 80; do
#    echo "==> Waiting for proxy to start"
#    sleep 1s & wait ${!}
# done

echo "==> Getting certificate for ${DOMAIN}"

certbot --verbose certonly \
    --webroot \
    --webroot-path "/usr/local/apache2/htdocs/" \
    --domain "${DOMAIN}" \
    --domain "www.${DOMAIN}" \
    --email ${EMAIL} \
    --rsa-key-size 4096 \
    --agree-tos \
    --non-interactive \
    --no-eff-email

# Check if DH params file exists, if not, generate it
if [ ! -f "/etc/letsencrypt/live/www.savysocials.com/ssl-dhparams.pem" ]; then
    openssl dhparam -out /etc/letsencrypt/live/www.savysocials.com/ssl-dhparams.pem 2048
fi
