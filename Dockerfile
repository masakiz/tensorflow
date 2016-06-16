FROM gcr.io/tensorflow/tensorflow

MAINTAINER masakiz

RUN apt-get update && apt-get install -y \
    wget \
    libopencv-dev \
    build-essential \
    checkinstall \
    cmake \
    git \
    pkg-config \
    yasm \
    libtiff4-dev \
    libjpeg-dev \
    libpng12-dev \
    libjasper-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libdc1394-22-dev \
    libxine-dev \
    libgstreamer0.10-dev \
    libgstreamer-plugins-base0.10-dev \
    libv4l-dev \
    libtbb-dev \
    libqt4-dev \
    libgtk2.0-dev \
    libmp3lame-dev \
    libopencore-amrnb-dev \
    libopencore-amrwb-dev \
    libtheora-dev \
    libvorbis-dev \
    libxvidcore-dev \
    x264 \
    v4l-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip && \
    pip --no-cache-dir install \
    pandas \
    statsmodels \
    seaborn

RUN mkdir /tmp/opencv && \
    cd /tmp/opencv && \
    git clone https://github.com/Itseez/opencv.git && \
    cd opencv && \
    git checkout 3.1.0 && \
    cd /tmp/opencv && \
    git clone https://github.com/Itseez/opencv_contrib.git && \
    cd opencv_contrib && \
    git checkout 3.1.0 && \
    cd /tmp/opencv/opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv/opencv_contrib/modules \
          -D BUILD_opencv_java=OFF \
          -D WITH_IPP=OFF \
          -D PYTHON_EXECUTABLE=/usr/bin/python2.7 .. && \
    make -j1 && \
    make install

RUN mkdir -p /notebooks/logs

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

VOLUME "/notebooks"

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh"]
