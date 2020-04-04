FROM php:7.4.4-apache

LABEL maintainer="Robbio <github.com/pigr8>" \
      architecture="amd64/x86_64" \
      debian-version="10 Buster" \
      apache-version="2.4.38" \
      php-fpm-version="7.4.4" \
      org.opencontainers.image.title="phpbb-3.3.0" \
      org.opencontainers.image.description="phpBB platform" \
      org.opencontainers.image.url="https://hub.docker.com/r/pigr8/phpbb-3.3.0/" \
      org.opencontainers.image.source="https://github.com/pigr8/phpbb-3.3.0"

ENV TZ Europe/Rome

RUN set -ex; \
      apt-get update && apt-get install -y \
      libpng-dev \
      libzip-dev \
      libjpeg-dev \
      unzip \
      zip
      
RUN set -ex; \
    docker-php-ext-configure gd --with-jpeg; \
    docker-php-ext-install -j "$(nproc)" \
        gd \
        mysqli \
        zip

RUN curl -o phpBB-3.3.0.zip "https://download.phpbb.com/pub/release/3.3/3.3.0/phpBB-3.3.0.zip"; \
    unzip -q phpBB-3.3.0.zip -d /var/www; \
    mv /var/www/phpBB3 /var/www/phpBB; \
    chown -R www-data:www-data /var/www/phpBB; \
    rm -rf /tmp/* /var/lib/apt/lists/*; \
    apt-get clean; \
    sed -i 's#DocumentRoot /var/www/html#DocumentRoot /var/www/phpBB#g' /etc/apache2/sites-available/000-default.conf
       

VOLUME /var/www/phpBB
WORKDIR /var/www

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]

CMD ["apache2-foreground"]
