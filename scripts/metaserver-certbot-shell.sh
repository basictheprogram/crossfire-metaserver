#!/bin/bash

source_env()
{
    # Check if .env file exists
    if [ -f ".env" ]; then
        # Loop through each line in the .env file
        while IFS='=' read -r var value; do
            # Skip lines that are empty or start with a comment
            if [[ -n "$var" && "$var" != \#* ]]; then
                # Export the variable
                export "$var=$value"
            fi
        done < .env
    else
        echo ".env file not found!"
    fi
}

export $(grep -v '^#' ../.env | xargs)

docker run --rm -it \
  --name crossfire-metaserver-certbot \
  --network metaserver \
  -e CERTBOT_EMAIL=${CERTBOT_EMAIL} \
  -e CERTBOT_DOMAIN=${CERTBOT_DOMAIN} \
  -p 80:80 \
  -v crossfire-metaserver-html-files:/var/www/html/:cached \
  -v crossfire-metaserver-letsencrypt:/etc/letsencrypt \
  basictheprogram/crossfire-metaserver-certbot /bin/sh
