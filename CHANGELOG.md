# Docker Image Packaging for MariaDB

## 10.4.x-0alvistack1 - TBC

### Major Changes

  - Revamp ENTRYPOINT so could pass <https://github.com/docker-library/official-images>
  - Revamp `/usr/local/bin/on-start.sh`, align with ENTRYPOINT changes
  - Add default `wsrep_cluster_address` with `gcomm://`
  - Add `/var/log/mysql/error.log`
  - Add `/var/log/on-start.sh.log`
  - Add some debug utils

## 10.4.0-0alvistack3 - 2018-12-15

### Major Changes

  - Add MariaDB 10.4 support

## 10.3.10-0alvistack2 - 2018-10-29

### Major Changes

  - Upgrade Docker base image to mariadb:10.3
  - Update dumb-init to v.1.2.2
  - Apply changes with patch
  - Always start apps with `gosu mysql`

## 10.2.13-0alvistack1 - 2018-03-12

  - Running MariaDB with Docker
  - Official MariaDB docker image based
  - Handle ENTRYPOINT with dumb-init
  - Hack original docker-entrypoint.sh for initialization only
  - Support Kubernetes StatefulSet with peer-finder
