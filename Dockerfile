FROM organizrtools/base-alpine-nginx
LABEL MAINTAINER="organizrTools,christronyxyocum"

# Add local files
COPY root/ /

# Ports and volumes
EXPOSE 80
VOLUME /config

# Container Healthcheck
HEALTHCHECK --start-period=60s CMD curl -ILfSs http://localhost:80/nginx_status > /dev/null || curl -ILfkSs https://localhost:80/status > /dev/null || exit 1