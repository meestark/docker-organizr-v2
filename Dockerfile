FROM lsiobase/alpine.nginx:3.8
MAINTAINER OrganizrTools

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
  php7-xmlrpc \
  mediainfo

# Add local files
COPY root/ /

# Creater Docker.txt for Org check
RUN true > /config/www/Dashboard/Docker.txt

# Ports and volumes
EXPOSE 80
VOLUME /config
