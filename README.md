# tensorflow

# Build
> docker build --no-cache --rm -t masakiz/tensorflow:0.9 .

# Run
> docker run --name tensorflow -p 6006:6006 -p 8888:8888 -v ${CWD}:/notebooks masakiz/tensorflow:0.9
