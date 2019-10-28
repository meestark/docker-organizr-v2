FROM organizrtools/base-alpine-nginx
LABEL MAINTAINER="organizrTools,christronyxyocum"

# Install packages
#RUN \
# apk add --no-cache \
#	curl \
#	php7-curl \
#	php7-ldap \
#	php7-pdo_sqlite \
#	php7-sqlite3 \
#	php7-session \
#	php7-zip \
#	php7-xmlrpc \
#	php7-ftp

# Add local files
COPY root/ /

# Ports and volumes
EXPOSE 80
VOLUME /config

# Container Healthcheck
HEALTHCHECK --start-period=60s CMD curl -ILfSs http://localhost:80/nginx_status > /dev/null || curl -ILfkSs https://localhost:80/status > /dev/null || exit 1