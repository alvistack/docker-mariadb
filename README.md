# Docker Image Packaging for MariaDB

<img src="/alvistack.svg" width="75" alt="AlviStack">

[![GitLab pipeline status](https://img.shields.io/gitlab/pipeline/alvistack/docker-mariadb/master)](https://gitlab.com/alvistack/docker-mariadb/-/pipelines)
[![GitHub tag](https://img.shields.io/github/tag/alvistack/docker-mariadb.svg)](https://github.com/alvistack/docker-mariadb/tags)
[![GitHub license](https://img.shields.io/github/license/alvistack/docker-mariadb.svg)](https://github.com/alvistack/docker-mariadb/blob/master/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/alvistack/mariadb-10.5.svg)](https://hub.docker.com/r/alvistack/mariadb-10.5)

MariaDB is a community-developed fork of the MySQL relational database management system intended to remain free under the GNU GPL. Being a fork of a leading open source software system, it is notable for being led by the original developers of MySQL, who forked it due to concerns over its acquisition by Oracle. Contributors are required to share their copyright with the MariaDB Foundation.

Learn more about MariaDB: <https://mariadb.org/>

## Supported Tags and Respective Packer Template Links

  - [`alvistack/mariadb-10.6`](https://hub.docker.com/r/alvistack/mariadb-10.6)
      - [`packer/docker-10.6/packer.json`](https://github.com/alvistack/docker-mariadb/blob/master/packer/docker-10.6/packer.json)
  - [`alvistack/mariadb-10.5`](https://hub.docker.com/r/alvistack/mariadb-10.5)
      - [`packer/docker-10.5/packer.json`](https://github.com/alvistack/docker-mariadb/blob/master/packer/docker-10.5/packer.json)
  - [`alvistack/mariadb-10.4`](https://hub.docker.com/r/alvistack/mariadb-10.4)
      - [`packer/docker-10.4/packer.json`](https://github.com/alvistack/docker-mariadb/blob/master/packer/docker-10.4/packer.json)

## Overview

This Docker container makes it easy to get an instance of MariaDB up and running.

Based on [Official Ubuntu Docker Image](https://hub.docker.com/_/ubuntu/) with some minor hack:

  - Packaging by Packer Docker builder and Ansible provisioner in single layer
  - Handle `ENTRYPOINT` with [catatonit](https://github.com/openSUSE/catatonit)
  - Use [Kubernetes Peer Finder](https://github.com/kubernetes/contrib/tree/master/peer-finder) to start the actual database instance with auto peer discovery

### Quick Start

For the `VOLUME` directory that is used to store the repository data (amongst other things) we recommend mounting a host directory as a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/#/data-volumes), or via a named volume if using a docker version \>= 1.9.

Start MariaDB:

    # Pull latest image
    docker pull alvistack/mariadb-10.5
    
    # Run as detach
    docker run \
        -itd \
        --name mariadb \
        --publish 3306:3306 \
        --volume /var/lib/mysql:/var/lib/mysql \
        --env MYSQL_ROOT_PASSWORD=Passw0rd\! \
        alvistack/mariadb-10.5

**Success**. MariaDB is now available on port 3306.

### Kubernetes StatefulSet

Be sure to use the `service.alpha.kubernetes.io/tolerate-unready-endpoints` on the governing headless service of the StatefulSet so that all peers are listed in endpoints before any peers are started, e.g.

    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: mariadb
      annotations:
        service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
      labels:
        service: mariadb
    spec:
      ports:
        - name: mysql
          port: 3306
        - name: state-snapshot-transfer
          port: 4444
        - name: replication-traffic
          port: 4567
        - name: incremental-state-transfer
          port: 4568
      selector:
        service: mariadb
      clusterIP: None

Also need to use `peer-finder` as wrapper in order to start daemon with peer auto discovery, e.g.

    ...
    containers:
      - name: mariadb
        image: alvistack/mariadb:latest
        imagePullPolicy: Always
        ports:
          - containerPort: 3306
          - containerPort: 4444
          - containerPort: 4567
          - containerPort: 4568
        env:
          - name: MYSQL_DATABASE
            value: "default"
          - name: MYSQL_ROOT_PASSWORD
            valueFrom:
              secretKeyRef:
                name: mariadb
                key: MYSQL_ROOT_PASSWORD
          - name: POD_NAMESPACE
            valueFrom:
              fieldRef:
                apiVersion: v1
                fieldPath: metadata.namespace
        args:
          - /bin/sh
          - -c
          - peer-finder -on-start=on-start.sh -service=mariadb
    ...

Checkout our [Kubernetes StatefulSet Example](https://github.com/alvistack/docker-mariadb/tree/master/kubernetes) for more information.

#### Limitations

In case of rolling upgrade or reboot which usually only single MariaDB instance goes offline, once it resumed no manual interrupt is required for automatic cluster recovery.

In case of unclean shutdown or hard crash, all nodes will have `safe_to_bootstrap: 0` therefore the automatic cluster recovery will be failed. You may simply delete *ALL* running MariaDB pods (which should already in `CrashLoopBackOff` status) so StatefulSet will help you bootstrap a new cluster one-node-by-one-node.

> Here we take a simple assumption that your 1st pod, i.e. `mariadb-0`, has committed the last transaction in the cluster, therefore bootstrap a new cluster from it. This will only be truth if *ALL* pods are unclean shutdown or hard crash *TOGETHER*, e.g. during data center power shortage. If you hope to ensure none of data loss during recovery, checkout official documents for more information.

### Environment Variables

Refer to [Official MariaDB Docker Image](https://hub.docker.com/_/mariadb/) for more information. Additionally:

#### POD\_NAMESPACE

The namespace this pod is running in, used by `peer-finder` when running as Kubernetes StatefulSet.

Default: `default`

## Versioning

### `YYYYMMDD.Y.Z`

Release tags could be find from [GitHub Release](https://github.com/alvistack/docker-mariadb/tags) of this repository. Thus using these tags will ensure you are running the most up to date stable version of this image.

### `YYYYMMDD.0.0`

Version tags ended with `.0.0` are rolling release rebuild by [GitLab pipeline](https://gitlab.com/alvistack/docker-mariadb/-/pipelines) in weekly basis. Thus using these tags will ensure you are running the latest packages provided by the base image project.

## License

  - Code released under [Apache License 2.0](LICENSE)
  - Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

## Author Information

  - Wong Hoi Sing Edison
      - <https://twitter.com/hswong3i>
      - <https://github.com/hswong3i>
