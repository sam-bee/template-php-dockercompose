FROM php:8-fpm-alpine

ARG DOCKERCOMPOSE_USERID
ARG DOCKERCOMPOSE_GROUPID

ENV DOCKERCOMPOSE_USERID=${DOCKERCOMPOSE_USERID}
ENV DOCKERCOMPOSE_GROUPID=${DOCKERCOMPOSE_GROUPID}

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN delgroup dialout

RUN addgroup -g ${DOCKERCOMPOSE_GROUPID} --system thedockeruser
RUN adduser -G thedockeruser --system -D -s /bin/sh -u ${DOCKERCOMPOSE_USERID} thedockeruser

RUN chown -R thedockeruser:thedockeruser /var/www/html

RUN sed -i "s/user = www-data/user = thedockeruser/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = thedockeruser/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

RUN docker-php-ext-install pdo pdo_mysql

USER thedockeruser

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
