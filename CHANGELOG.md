# Docker Image Packaging for MariaDB

## YYYYMMDD.Y.Z - TBC

### Major Changes

## 20220520.1.1 - 2022-05-20

### Major Changes

  - Support Ansible community package 5.8.0
  - Remove Fedora 34 support

## 20220427.1.1 - 2022-04-27

### Major Changes

  - Rename Ansible Role with FQCN
  - Support Ansible community package 5.7.0
  - Ubuntu 22.04 based
  - Support RHEL 9
  - Support CentOS 9 Stream
  - Support openSUSE Leap 15.4

## 20220407.1.2 - 2022-04-07

### Major Changes

  - Support Ansible community package 5.6.0
  - Support Fedora 36
  - Support Ubuntu 22.04
  - Support Ansible community package 5.5.0
  - Support Ansible community package 5.4.0

## 20220211.1.1 - 2022-02-11

### Major Changes

  - Remove Ubuntu 21.04 support
  - Skip package upgrade before running molecule

## 20211231.1.3 - 2021-12-31

### Major Changes

  - Support Fedora Rawhide
  - Support Debian Testing
  - Remove openSUSE Leap 15.2 support
  - Upgrade minimal Ansible community package support to 4.10
  - Support MariaDB 10.6
  - Remove MariaDB 10.3 support

## 20211020.1.1 - 2021-10-20

### Major Changes

  - Install dependencies with package manager
  - Upgrade minimal Ansible community package support to 4.7.0

## 20210718.1.1 - 2021-07-18

### Major Changes

  - Upgrade minimal Ansible community package support to 4.2.0

## 20210602.1.1 - 2021-06-02

### Major Changes

  - Upgrade minimal Ansible support to 4.0.0

## 20210313.1.1 - 2021-03-13

### Major Changes

  - Bugfix [ansible-lint `namespace`](https://github.com/ansible-community/ansible-lint/pull/1451)
  - Bugfix [ansible-lint `no-handler`](https://github.com/ansible-community/ansible-lint/pull/1402)
  - Bugfix [ansible-lint `unnamed-task`](https://github.com/ansible-community/ansible-lint/pull/1413)
  - Change GIT tag as per Vagrant Box naming and versioning limitation

## 10.5.7-4alvistack2 - 2020-12-09

### Major Changes

  - Migrate from Travis CI to GitLab CI
  - Revamp with Packer

## 10.5.5-4alvistack4 - 2020-10-14

### Major Changes

  - Refine Molecule matrix

## 10.5.5-4alvistack1 - 2020-08-26

### Major Changes

  - Upgrade minimal Ansible Lint support to 4.3.2
  - Upgrade Travis CI test as Ubuntu Focal based
  - Upgrade minimal Ansible support to 2.10.0

## 10.5.3-4alvistack2 - 2020-06-10

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
