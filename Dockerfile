FROM lsiobase/alpine.nginx.armhf:3.7
MAINTAINER christronyxyocum

# Copy the qemu-arm-static file
COPY qemu-arm-static /usr/bin/qemu-arm-static

# Set version label
ARG BUILD_DATE
ARG VERSION

# Install packages
RUN \
 apk add --no-cache \
	curl \
	php7-curl \
	php7-ldap \
	php7-pdo_sqlite \
	php7-sqlite3 \
	php7-session \
	php7-zip \
  mediainfo

# Add local files
COPY root/ /

# Ports and volumes
EXPOSE 80
VOLUME /config
