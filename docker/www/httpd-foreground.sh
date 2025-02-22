#!/bin/sh
set -e

production() {
    echo "==> Checking for /etc/letsencrypt/live/${APACHE_SERVER_NAME}"
    if [ ! -d "/etc/letsencrypt/live/${APACHE_SERVER_NAME}" ]; then
        echo "==> Creating "/etc/letsencrypt/live/${APACHE_SERVER_NAME}
        mkdir -p "/etc/letsencrypt/live/${APACHE_SERVER_NAME}"
    fi

    echo "==> Checking for dhparams.pem"
    if [ ! -f "/etc/letsencrypt/live/${APACHE_SERVER_NAME}/ssl-dhparams.pem" ]; then
        echo "==> Generating dhparams.pem"
        openssl dhparam -out "/etc/letsencrypt/live/${APACHE_SERVER_NAME}/ssl-dhparams.pem" 2048
    fi

    echo "==> Checking for ${APACHE_SERVER_NAME}/fullchain.pem"
    if [ ! -f "/etc/letsencrypt/live/${APACHE_SERVER_NAME}/fullchain.pem" ]; then
        echo "==> No SSL certificate, enabling HTTP only"
        envsubst < /etc/apache2/sites-available/metaserver.conf.template > /etc/apache2/sites-available/metaserver.conf
    else
        echo "==> SSL certificate found, enabling HTTPS"
        envsubst < /etc/apache2/sites-available/metaserver-ssl.conf.template > /etc/apache2/sites-available/metaserver.conf
    fi
}

# Apache gets grumpy about PID files pre-existing
# rm -f /usr/local/apache2/logs/httpd.pid

if [ ! -x /usr/bin/envsubst ]; then
    echo "==> Error: Cannot envsubst! Aborting."
    exit 1
fi

if [ -z $APACHE_SERVER_ADMIN ]; then
    echo "==> Error: APACHE_SERVER_ADMIN variable is blank! Aboring."
    exit 1
fi

if [ -z $APACHE_SERVER_NAME ]; then
    echo "==> Error: APACHE_SERVER_NAME variable is blank! Aboring."
    exit 1
fi

echo "==> Production environment"
production

exec httpd -DFOREGROUND "$@"
