FROM php:8-apache

LABEL maintainer="tanner@real-time.com"

ARG APACHE_SERVER_ADMIN
ARG APACHE_SERVER_NAME

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update -qq \
   && apt-get dist-upgrade -qq \
   && apt-get install -qq --no-install-recommends \
        less \
        default-mysql-client \
        python3-mysqldb \
        gettext-base \
   && docker-php-ext-configure mysqli \
   && docker-php-ext-install mysqli \
   && apt-get autoremove \
   && apt-get clean  \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./metaserver.conf.template /etc/apache2/sites-available/metaserver.conf.template

RUN a2dissite 000-default.conf a2default-ssl.conf || true \
    && rm -f /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 443
