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

VOLUME /var/www/phpBB

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libzip-dev \
    libjpeg-dev \
    unzip \
    zip
    && apt-get clean
    && /var/lib/apt/lists/*```

RUN set -ex; \
    docker-php-ext-configure gd --with-jpeg; \
    docker-php-ext-install -j "$(nproc)" \
      gd \
      mysqli \
      zip    

# Setting up the Container and Supervisor
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 80

CMD ["bash"]
