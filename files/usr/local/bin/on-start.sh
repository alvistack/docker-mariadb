#!/bin/bash

set -ex

HOSTNAME=$(hostname -f)
WSREP_CLUSTER_ADDRESS=$(tee | paste -sd , -)
ARGS="$ARGS --wsrep-cluster-address=gcomm://$WSREP_CLUSTER_ADDRESS"

if [ "$WSREP_CLUSTER_ADDRESS" == "$HOSTNAME" ]; then
    sed -i 's/^\(safe_to_bootstrap\):.*$/\1: 1/g' /var/lib/mysql/grastate.dat
    ARGS="$ARGS --wsrep-new-cluster"
fi

exec docker-entrypoint.sh $ARGS
