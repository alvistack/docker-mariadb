# Docker Image Packaging for MariaDB

## 10.5.3-XalvistackY - TBC

### Major Changes

  - Revamp `create`, `side_effect`, `verify` and `destroy` logic
  - Replace `tini` with `catatonit`
  - Rename `post_tasks.yml` as `side_effect.yml`
  - Upgrade base image to Ubuntu 20.04

## 10.4.12-4alvistack4 - 2020-03-05

### Major Changes

  - Revamp with Molecule and `docker commit`
  - Consolidate molecule tests into `default` (noop)
  - Hotfix for systemd

## 10.4.11-3alvistack1 - 2020-01-15

### Major Changes

  - Replace `dumb-init` with `tini`, as like as `docker --init`
  - Include release specific vars and tasks
  - Revamp template for `/etc/mysql/my.cnf`
  - Backport `/usr/local/bin/docker-entrypoint.sh` from upstream
  - Debug `/usr/local/bin/on-start.sh` for Kubernetes

## 10.4.8-2alvistack3 - 2019-11-05

### Major Changes

  - Upgrade minimal Ansible support to 2.9.0
  - Upgrade Travis CI test as Ubuntu Bionic based
  - Default with Python 3
  - Hotfix for en\_US.utf8 locale
  - Install peer-finder for Kubernetes manually
  - Remove MariaDB 10.1 support

## 10.4.8-1alvistack1 - 2019-10-15

### Major Changes

  - Revamp as Ansible based

## 10.4.4-0alvistack3 - 2019-05-20

### Major Changes

  - Bugfix "Build times out because no output was received"

## 10.4.4-0alvistack1 - 2019-04-16

### Major Changes

  - Improve checksum handling

## 10.4.3-0alvistack2 - 2019-03-18

### Major Changes

  - Revamp ENTRYPOINT so could pass <https://github.com/docker-library/official-images>
  - Revamp `/usr/local/bin/on-start.sh`, align with ENTRYPOINT changes
  - Add default `wsrep_cluster_address` with `gcomm://`
  - Add `/var/log/mysql/error.log`
  - Add `/var/log/on-start.sh.log`
  - Add some debug utils
  - Add checksum for curl

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
