FROM php:7.4-apache-buster

MAINTAINER walkonthemarz@gmail.com

ARG APCU_VERSION=5.1.18
ARG REDIS_VERSION=5.1.1
ARG MCRYPT_VERSION=1.0.3

RUN apt update \
      && apt upgrade -y \
      && apt install -y wget \
      && a2enmod rewrite \
      && apt install -y libmcrypt-dev libonig-dev \
      && apt install -y mariadb-client
RUN docker-php-ext-install bcmath \
      && docker-php-ext-install mbstring \
      && docker-php-ext-install ctype \
      && docker-php-ext-install pdo_mysql \
      && docker-php-ext-install tokenizer \
      && docker-php-ext-install mysqli \
      && pecl install redis-${REDIS_VERSION} && docker-php-ext-enable redis \
      && pecl install mcrypt-${MCRYPT_VERSION} && docker-php-ext-enable mcrypt \
      && pecl install apcu-${APCU_VERSION} && docker-php-ext-enable apcu \
      && docker-php-source delete

WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
