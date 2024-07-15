# FROM httpd:latest
FROM php:8.0-apache

LABEL maintainer="tanner@real-time.com"

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago

ENV USER_UID=1000
ENV USER_GID=1000
ENV USERNAME="you"

RUN apt-get update -qq && \
   apt-get dist-upgrade -qq && \
   apt-get install -qq --no-install-recommends \
   less \
   default-mysql-client \
   python3-mysqldb && \
   docker-php-ext-install mysqli && \
   apt-get autoremove && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash

# RUN rm -f /usr/local/apache2/conf/extra/httpd-dav.conf

# COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
# COPY ./httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 443
