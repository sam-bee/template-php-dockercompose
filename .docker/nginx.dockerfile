FROM nginx:stable-alpine

ARG DOCKERCOMPOSE_USERID
ARG DOCKERCOMPOSE_GROUPID

ENV DOCKERCOMPOSE_USERID=${DOCKERCOMPOSE_USERID}
ENV DOCKERCOMPOSE_GROUPID=${DOCKERCOMPOSE_GROUPID}

RUN delgroup dialout

RUN addgroup -g ${DOCKERCOMPOSE_GROUPID} --system thedockeruser
RUN adduser -G thedockeruser --system -D -s /bin/sh -u ${DOCKERCOMPOSE_USERID} thedockeruser
RUN sed -i "s/user  nginx/user thedockeruser/g" /etc/nginx/nginx.conf

ADD ./nginx/default.conf /etc/nginx/conf.d/

RUN mkdir -p /var/www/html

RUN chown -R thedockeruser:thedockeruser /var/www/html
