<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> e69ad672795b1eaddf924824b29df86eadd24b47
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

COPY ./docker/www/*.conf.template /etc/apache2/sites-available/

RUN a2dissite 000-default.conf a2default-ssl.conf || true \
    && a2enmod ssl dir \
    && rm -f /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf \
    && mkdir -p /opt/www

COPY ./docker/www/apache-foreground.sh  /opt/www/apache-foreground.sh
COPY ./html/ /var/www/html/
<<<<<<< HEAD
=======
=======
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
>>>>>>> 1e01009 (feat: Add development container setup with Docker and VSCode)
>>>>>>> e69ad672795b1eaddf924824b29df86eadd24b47

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 443
<<<<<<< HEAD

CMD ["/opt/www/apache-foreground.sh"]
=======
<<<<<<< HEAD

CMD ["/opt/www/apache-foreground.sh"]
=======
>>>>>>> 1e01009 (feat: Add development container setup with Docker and VSCode)
>>>>>>> e69ad672795b1eaddf924824b29df86eadd24b47
