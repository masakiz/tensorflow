#!/bin/bash

if [ -z "${LOGDIR}" ]; then
    export LOGDIR=/notebooks/logs
fi

mkdir -p ${LOGDIR} 2>/dev/null
tensorboard --logdir=${LOGDIR} &

echo "c.NotebookApp.token = u''" >> ~/.jupyter/jupyter_notebook_config.py

jupyter notebook --allow-root --ip=0.0.0.0 --NotebookApp.token= "$@"
