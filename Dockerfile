FROM tensorflow/tensorflow:2.0.1-gpu-py3

MAINTAINER masakiz

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y \
    wget \
    git \
    libpq-dev \
    xclip \
    python-dev \
    pandoc \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    mecab \
    libmecab-dev \
    mecab-ipadic \
    mecab-ipadic-utf8 \
    python-mecab \
    openjdk-11-jdk \
    ca-certificates-java \
    automake \
    autotools-dev \
    g++ \
    git \
    libcurl4-gnutls-dev \
    libfuse-dev \
    libssl-dev \
    libjsoncpp-dev \
    make \
    pkg-config \
    gzip \
    bzip2 \
    python3-tk \
    fonts-migmix \
    cron \
    file \
    sudo

RUN apt-get -y install \
    libopencv-dev \
    build-essential \
    cmake \
    git \
    pkg-config \
    python-dev \
    python-numpy \
    libgtk2.0-dev \
    libdc1394-22 \
    libdc1394-22-dev \
    libjpeg-dev \
    libtiff5-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libxine2-dev \
    libv4l-dev \
    libtbb-dev \
    libqt4-dev \
    libfaac-dev \
    libmp3lame-dev \
    libopencore-amrnb-dev \
    libopencore-amrwb-dev \
    libtheora-dev \
    libvorbis-dev \
    libxvidcore-dev \
    libtbb2 \
    libtbb-dev \
    x264 \
    v4l-utils

RUN update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip && \
    pip --no-cache-dir install \
    pandas \
    pandas-datareader \
    statsmodels \
    scikit-learn \
    seaborn \
    psycopg2 \
    sympy \
    sqlalchemy \
    html5lib \
    beautifulsoup4 \
    xlrd \
    xlsxwriter \
    openpyxl \
    h5py \
    mecab-python3 \
    Cython \
    gensim \
    PyAthenaJDBC \
    selenium \
    flask \
    peewee \
    simple-salesforce \
    uwsgi \
    pydotplus \
    pydot \
    scipy \
    xgboost \
    pypandoc \
    graphviz \
    jupyterlab

RUN pip --no-cache-dir install word2vec fasttext deap

RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git /usr/src/s3fs-fuse && \
    cd /usr/src/s3fs-fuse && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make && \
    make install

RUN cd ~ && \
    git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    ./bin/install-mecab-ipadic-neologd -n -a -y && \
    sed -ri 's:dicdir = /var/lib/mecab/dic/debian:dicdir = /usr/lib/mecab/dic/mecab-ipadic-neologd:g' /etc/mecabrc

#RUN mkdir opencv && \
#    cd opencv && \
#    curl -L https://github.com/opencv/opencv/archive/4.3.0.tar.gz | tar xz && \
#    mkdir build && \
#    cd build && \
#    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ../opencv-4.3.0 && \
#    make -j $(nproc) && \
#    make install

COPY run.sh /

RUN mkdir -p /notebooks/logs

# TensorBoard
EXPOSE 6006
# Jupyter
EXPOSE 8888

VOLUME "/notebooks"

WORKDIR "/notebooks"

CMD ["sh", "/run.sh"]
