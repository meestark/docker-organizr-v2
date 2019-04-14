Fork of the LSIO Organizr Docker container to include the Organizr v2 master branch.

# organizrTools/docker-organizr-v2

Feel free to submit Pull Requests and report any Issues that you may have found.

## Organizr

[![Build Status](https://travis-ci.org/organizrTools/docker-organizr-v2.svg?branch=armhf)](https://travis-ci.org/organizrTools/docker-organizr-v2)

An HTPC/Homelab services organizer that is written in PHP.

![Organizr](https://cloud.githubusercontent.com/assets/16184466/24440636/1e5e2002-140a-11e7-8da1-1cd68745cedd.png)

## Usage

```
docker create \
  --name=organizr \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 80:80 \
  organizrtools/organizr-v2
```

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container. So `-p 8080:80` would expose port 80 from inside the container to be accessible from the host's IP on port 8080 and `http://192.168.x.x:8080` would show you what's running INSIDE the container on port 80.

* `-p 80` - The port(s)
* `-v /config` - Mapping the config files for Organizr
* `-e PGID` Used for GroupID - see below for explanation
* `-e PUID` Used for UserID - see below for explanation

It is based on Alpine Linux with an s6 overlay.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Image Tags

* The `latest` tag will get you the original Organizr v2 image.
* The `php-fpm` tag includes the implementation of PHP-FPM within the container instead of the default FastCGI. PHP-FPM is much more efficient, especially in terms of memory, and will include the recommended PM changes for the `www.conf` file that we recommend to users that are just getting started. One thing to note is that, if you mounted the `/etc/php7/php-fpm.d/` directory for the container to your Host, you MUST recreate your container WITHOUT that mount. You will also want to remove the `/path/to/Org/config/php` directory from your Docker Host as that can cause issues as well. This is designed as a drop-in to get PHP-FPM working without having to mount extra directories, etc.
* The `plex` tag will get you the original Organizr v2 image, but with some changes found in the plex-theme branch of the GitHub repo to accommodate the [Plex Theme](https://github.com/Burry/organizr-v2-plex-theme) for Organizr v2 by Burry.
* The `armhf` tag is an adaptation of the `php-fpm` image for ArmHF platforms like the RaspberryPi.

NOTE: Switching to OR from the `php-fpm` or `dev-php-fpm` tags to/from ANY other tag will result in an error as they use a socket for the PHP-FPM connection. You will need to backup and then rename/remove your `/config/nginx/site-confs/default` and `/config/php/www.conf` files, then restart the container.

## Setting up the application

Setup accounts, service tabs, etc. via the webUI. More info can be found on the official [Organizr GitHub repository](https://github.com/causefx/Organizr/).

## Info

* Shell access whilst the container is running: `docker exec -it organizr /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f organizr`
* Container version number: `docker inspect -f '{{ index .Config.Labels "build_version" }}' organizr`
* Image version number: `docker inspect -f '{{ index .Config.Labels "build_version" }}' organizrtools/docker-organizr-v2`
