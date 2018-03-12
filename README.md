Docker Image Packaging for MariaDB
==================================

[![Travis](https://img.shields.io/travis/alvistack/docker-mariadb.svg)](https://travis-ci.org/alvistack/docker-mariadb)
[![GitHub release](https://img.shields.io/github/release/alvistack/docker-mariadb.svg)](https://github.com/alvistack/docker-mariadb/releases)
[![GitHub license](https://img.shields.io/github/license/alvistack/docker-mariadb.svg)](https://github.com/alvistack/docker-mariadb/blob/master/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/alvistack/mariadb.svg)](https://hub.docker.com/r/alvistack/mariadb/)

MariaDB is a community-developed fork of the MySQL relational database management system intended to remain free under the GNU GPL. Being a fork of a leading open source software system, it is notable for being led by the original developers of MySQL, who forked it due to concerns over its acquisition by Oracle. Contributors are required to share their copyright with the MariaDB Foundation.

Learn more about MariaDB: <https://mariadb.org/>

Supported Tags and Respective Dockerfile Links
----------------------------------------------

-   [10.3 (10.3.x/Dockerfile)](https://github.com/alvistack/docker-mariadb/blob/10.3.x/Dockerfile)
-   [10.2, latest (master/Dockerfile](https://github.com/alvistack/docker-mariadb/blob/master/Dockerfile)
-   [10.1 (10.1.x/Dockerfile)](https://github.com/alvistack/docker-mariadb/blob/10.1.x/Dockerfile)
-   [10.0 (10.0.x/Dockerfile)](https://github.com/alvistack/docker-mariadb/blob/10.0.x/Dockerfile)
-   [5.5 (5.5.x/Dockerfile)](https://github.com/alvistack/docker-mariadb/blob/5.5.x/Dockerfile)

Overview
--------

This Docker container makes it easy to get an instance of MariaDB up and running.

Based on [Official MariaDB Docker Image](https://hub.docker.com/_/mariadb/) with some hack for use cases in [Kubernetes StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/):

-   Handle `ENTRYPOINT` with [dumb-init](https://github.com/Yelp/dumb-init)
-   `docker-entrypoint.sh` will *NOT* handle the start of PID 1, therefore you could execute it independently with [Kubernetes Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) for initializing [MySQL Data Directory](https://dev.mysql.com/doc/refman/5.7/en/data-directory.html)
-   Use [Kubernetes Peer Finder](https://github.com/kubernetes/contrib/tree/master/peer-finder) to start the actual database instance with auto peer discovery

### Quick Start

For the `VOLUME` directory that is used to store the repository data (amongst other things) we recommend mounting a host directory as a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/#/data-volumes), or via a named volume if using a docker version &gt;= 1.9.

Start MariaDB:

    # Pull latest image
    docker pull alvistack/mariadb

    # To initialize VOLUME
    docker run \
        -it \
        --rm \
        --name mariadb \
        --volume /var/lib/mysql:/var/lib/mysql \
        --env MYSQL_ROOT_PASSWORD=Passw0rd\! \
        alvistack/mariadb \
        docker-entrypoint.sh mysqld --wsrep-new-cluster --wsrep-cluster-address=gcomm://

    # Run as detach
    docker run \
        -itd \
        --name mariadb \
        --publish 3306:3306 \
        --publish 4444:4444 \
        --publish 4567:4567 \
        --publish 4568:4568 \
        --volume /var/lib/mysql:/var/lib/mysql \
        alvistack/mariadb \
        mysqld --wsrep-new-cluster --wsrep-cluster-address=gcomm://

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

See [Kubernetes example](/kubernetes) for more information.

#### Limitations

In case of rolling upgrade or reboot which usually only single MariaDB instance goes offline, once it resumed no manual interrupt is required for automatic cluster recovery.

In case of unclean shutdown or hard crash, all nodes will have `safe_to_bootstrap: 0` therefore the automatic cluster recovery will be failed. You may simply delete *ALL* running MariaDB pods (which should already in `CrashLoopBackOff` status) so StatefulSet will help you bootstrap a new cluster one-node-by-one-node.

> Here we take a simple assumption that your 1st pod, i.e. `mariadb-0`, has committed the last transaction in the cluster, therefore bootstrap a new cluster from it. This will only be truth if *ALL* pods are unclean shutdown or hard crash *TOGETHER*, e.g. during data center power shortage. If you hope to ensure none of data loss during recovery, checkout official documents for more information.

### Environment Variables

Refer to [Official MariaDB Docker Image](https://hub.docker.com/_/mariadb/) for more information. Additionally:

#### POD\_NAMESPACE

The namespace this pod is running in, used by `peer-finder` when running as Kubernetes StatefulSet.

Default: `default`

Versioning
----------

The `latest` tag matches the most recent version of this repository. Thus using `alvistack/mariadb:latest` or `alvistack/mariadb` will ensure you are running the most up to date version of this image.

License
-------

-   Code released under [Apache License 2.0](LICENSE)
-   Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

Author Information
------------------

-   Wong Hoi Sing Edison
    -   <https://twitter.com/hswong3i>
    -   <https://github.com/hswong3i>

