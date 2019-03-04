#!/bin/bash

set -o pipefail

PID_FILE="/var/run/${0##*/}.pid"
LOG_FILE="/var/log/${0##*/}.log"

exec 1> >(tee -a $LOG_FILE) 2>&1

HOSTNAME=$(hostname -f)
WSREP_CLUSTER_ADDRESS=$(tee | paste -sd , -)
ARGS="--wsrep-cluster-address=gcomm://$WSREP_CLUSTER_ADDRESS"

if [ "$WSREP_CLUSTER_ADDRESS" == "$HOSTNAME" ]; then
    sed -i 's/^\(safe_to_bootstrap\):.*$/\1: 1/g' /var/lib/mysql/grastate.dat || true
    ARGS="$ARGS --wsrep-new-cluster"
fi

exec docker-entrypoint.sh mysqld $ARGS
