FROM  gcr.io/tensorflow/tensorflow

MAINTAINER masakiz

ENV OPENCV_VERSION 3.1.0

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    libgtk2.0-dev \
    libjpeg8-dev \
    libpng-dev \
    libtiff4-dev \
    libjasper-dev \
    libpng12-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libatlas-base-dev \
    gfortran \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir opencv \
    cd opencv \
    wget https://sourceforge.net/projects/opencvlibrary/files/opencv-unix/${OPENCV_VERSION}/opencv-${OPENCV_VERSION}.zip \
    unzip opencv-${OPENCV_VERSION}.zip \
    cd opencv-${OPENCV_VERSION}/ \
    mkdir build \
    cd build \
    make -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_opencv_java=OFF -D WITH_IPP=OFF -D WITH_1394=OFF -D WITH_FFMPEG=OFF -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_DOCS=OFF -D BUILD_opencv_python2=ON -D BUILD_opencv_python3=ON -D BUILD_opencv_video=OFF -D BUILD_opencv_videoio=OFF -D BUILD_opencv_videostab=OFF -D PYTHON_EXECUTABLE=$(which python) .. \
    make \
    sudo make install

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh"]
