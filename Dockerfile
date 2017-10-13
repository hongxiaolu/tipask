FROM php:5.6.31-fpm-alpine

ENV version=3.2

RUN apt-get update && apt-get install unzip   \
    && rm -rf /tmp && cd /tmp && curl -O  https://www.tipask.com/release/Tipask_v"$version"_UTF8_20170412.zip  \
    && unzip Tipask_v"$version"*.zip \
    && mv tipask* /home/tipask  && rm -rf /tmp

COPY apache2-foreground /usr/local/bin/

RUN echo "$version">/home/tipask/version  && chmod +x /usr/local/bin/apache2-foreground

CMD ["apache2-foreground"]