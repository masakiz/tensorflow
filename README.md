# tensorflow

# Build
> docker build --no-cache --rm -t masakiz/tensorflow:1.2.0-gpu .

# Run
> nvidia-docker run --name tensorflow -p 6006:6006 -p 8888:8888 -v $PWD/notebooks:/notebooks -e PASSWORD=<login password> -e LOGDIR=/notebooks/logs -e LANG=ja_JP.UTF-8 masakiz/tensorflow:1.2.0-gpu
