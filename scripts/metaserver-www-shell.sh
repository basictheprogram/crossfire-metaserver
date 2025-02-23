#!/bin/bash

source_env()
{
    # Check if .env file exists
    if [ -f "../.env" ]; then
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

docker pull basictheprogram/crossfire-metaserver-www
docker run -it --rm \
  --name crossfire-metaserver-www \
  --env DB_HOST=${DB_HOST} \
  --env DB_USER=${DB_USER} \
  --env DB_PWD=${DB_PWD} \
  --env DB_NAME=${DB_NAME} \
  --env APACHE_SERVER_ADMIN=${APACHE_SERVER_ADMIN} \
  --env APACHE_SERVER_NAME=${APACHE_SERVER_NAME} \
  -v crossfire-metaserver-html-files:/var/www/html:cached \
  -v crossfire-metaserver-letsencrypt:/etc/letsencrypt \
  -p 80:80 \
  -p 443:443 \
  --network metaserver \
  basictheprogram/crossfire-metaserver-www /bin/bash

