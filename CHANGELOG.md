# Docker Image Packaging for MariaDB

## 10.3.10-0alvistack3 - TBC

## 10.3.10-0alvistack2 - 2018-10-29

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
