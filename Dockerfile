FROM php:5.6.31-apache

ENV version=3.2
# Install
RUN sed -i 's/deb.debian.org/debian.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt-get update && apt-get install -y \
        gcc g++ \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        unzip \
    &&  docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd  \
    && docker-php-ext-install pdo pdo_mysql \
    && rm -rf /tmp/*  && cd /tmp && curl -O  https://www.tipask.com/release/Tipask_v"$version"_UTF8_20170412.zip  \
    && unzip Tipask_v"$version"*.zip \
    && mv tipask* /home/tipask  && rm -rf /tmp  && a2enmod rewrite

COPY apache2-foreground /usr/local/bin/

RUN echo "$version">/home/tipask/version  && chmod +x /usr/local/bin/apache2-foreground  &&  chown -R www-data:www-data /var/www/html/

CMD ["apache2-foreground"]