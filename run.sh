#!/bin/bash

if [ -z "${LOGDIR}" ]; then
    export LOGDIR=/notebooks/logs
fi

mkdir -p ${LOGDIR} 2>/dev/null
tensorboard --logdir=${LOGDIR} &

jupyter notebook --allow-root "$@"
