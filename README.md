Docker Image Packaging for MariaDB
====================================

[![Travis](https://img.shields.io/travis/alvistack/docker-mariadb.svg)](https://travis-ci.org/alvistack/docker-mariadb)
[![GitHub release](https://img.shields.io/github/release/alvistack/docker-mariadb.svg)](https://github.com/alvistack/docker-mariadb/releases)
[![GitHub license](https://img.shields.io/github/license/alvistack/docker-mariadb.svg)](https://github.com/alvistack/docker-mariadb/blob/master/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/alvistack/mariadb.svg)](https://hub.docker.com/r/alvistack/mariadb/)

MariaDB is a community-developed fork of the MySQL relational database management system intended to remain free under the GNU GPL. Being a fork of a leading open source software system, it is notable for being led by the original developers of MySQL, who forked it due to concerns over its acquisition by Oracle. Contributors are required to share their copyright with the MariaDB Foundation.

Learn more about MariaDB: <https://mariadb.org/>

Overview
--------

This Docker container makes it easy to get an instance of MariaDB up and running.

Based on official [MariaDB Docker Image](https://hub.docker.com/_/mariadb/) will some hack for use cases in Kubernetes StatefulSet:

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

