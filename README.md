# tensorflow

# Build
> nvidia-docker build --no-cache --rm -t masakiz/tensorflow:2.0.1-gpu .

# Run
> nvidia-docker run --name tensorflow -p 6006:6006 -p 8888:8888 -v $PWD/notebooks:/notebooks -e LOGDIR=/notebooks/logs -e LANG=ja_JP.UTF-8 masakiz/tensorflow:2.0.1-gpu
