#!/bin/bash

tensorboard --logdir=/notebooks/logs
jupyter notebook "$@"
