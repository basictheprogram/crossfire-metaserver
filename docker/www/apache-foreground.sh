#!/bin/bash
set -e

# Taken from https://github.com/docker-library/php/blob/master/apache2-foreground
upstream()
{
    # Note: we don't just use "apache2ctl" here because it itself is just a shell-script wrapper
    # around apache2 which provides extra functionality like "apache2ctl start" for launching apache2
    # in the background.
    # (also, when run as "apache2ctl <apache args>", it does not use "exec", which leaves an undesirable
    # resident shell process)

    : "${APACHE_CONFDIR:=/etc/apache2}"
    : "${APACHE_ENVVARS:=$APACHE_CONFDIR/envvars}"
    if test -f "$APACHE_ENVVARS"; then
        . "$APACHE_ENVVARS"
    fi

    # Apache gets grumpy about PID files pre-existing
    : "${APACHE_RUN_DIR:=/var/run/apache2}"
    : "${APACHE_PID_FILE:=$APACHE_RUN_DIR/apache2.pid}"
    rm -f "$APACHE_PID_FILE"

    # create missing directories
    # (especially APACHE_RUN_DIR, APACHE_LOCK_DIR, and APACHE_LOG_DIR)
    for e in "${!APACHE_@}"; do
        if [[ "$e" == *_DIR ]] && [[ "${!e}" == /* ]]; then
            # handle "/var/lock" being a symlink to "/run/lock", but "/run/lock" not existing beforehand, so "/var/lock/something" fails to mkdir
            #   mkdir: cannot create directory '/var/lock': File exists
            dir="${!e}"
            while [ "$dir" != "$(dirname "$dir")" ]; do
                dir="$(dirname "$dir")"
                if [ -d "$dir" ]; then
                    break
                fi
                absDir="$(readlink -f "$dir" 2>/dev/null || :)"
                if [ -n "$absDir" ]; then
                    mkdir -p "$absDir"
                fi
            done

            mkdir -p "${!e}"
        fi
    done
}

production()
{
    LIVE_PATH="/etc/letsencrypt/live/${APACHE_SERVER_NAME}"
    SSL_DH_PARAMS="${LIVE_PATH}/ssl-dhparams.pem"
    CERT_PATH="${LIVE_PATH}/fullchain.pem"
    KEY_PATH="${LIVE_PATH}/privkey.pem"

    echo "==> Checking for ${LIVE_PATH}"
    if [ ! -d ${LIVE_PATH} ]; then
        echo "==> Creating ${LIVE_PATH}"
        mkdir -p ${LIVE_PATH}
    fi

    echo "==> Checking for dhparams.pem"
    if [ ! -f ${SSL_DH_PARAMS} ]; then
        echo "==> Generating dhparams.pem"
        openssl dhparam -out ${SSL_DH_PARAMS} 2048
    fi

    echo "==> Checking for ${CERT_PATH} and ${KEY_PATH}"

    # Wait for Certbot to finish and certificates to be available
    while [ ! -f "$CERT_PATH" ] || [ ! -f "$PRIV_KEY_PATH" ]; do
        echo "Waiting for Certbot to complete certificate issuance..."
        sleep 5
    done

    echo "==> SSL certificate found, enabling HTTPS"
    envsubst < /etc/apache2/sites-available/metaserver-ssl.conf.template > /etc/apache2/sites-available/metaserver.conf
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

if [ ! -x /usr/sbin/apache2 ]; then
    echo "==> Error: apache2 not found or not executable! Aboring."
    exit 1
fi

echo "==> Production environment"
upstream
production

exec apache2 -DFOREGROUND "$@"
