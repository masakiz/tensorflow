FROM tensorflow/tensorflow:1.1.0-py3

MAINTAINER masakiz

RUN apt-get update && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y \
    wget \
    git \
    libpq-dev \
    xclip \
    python-dev \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    mecab \
    libmecab-dev \
    mecab-ipadic \
    mecab-ipadic-utf8 \
    python-mecab \
    openjdk-8-jdk \
    ca-certificates-java \
    automake \
    autotools-dev \
    g++ \
    git \
    libcurl4-gnutls-dev \
    libfuse-dev \
    libssl-dev \
    libxml2-dev \
    make \
    pkg-config \
    gzip \
    bzip2 \
    fonts-migmix \
    && \
    update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java && \
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
    keras \
    h5py \
    mecab-python3 \
    Cython \
    gensim \
    PyAthenaJDBC \
    selenium \
    flask \
    peewee
RUN pip --no-cache-dir install word2vec

RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git /usr/src/s3fs-fuse && \
    cd /usr/src/s3fs-fuse && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make && \
    make install

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    tar jxvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/

RUN mkdir ~/.keras && \
    echo "{\"backend\": \"tensorflow\"}" > ~/.keras/keras.json

COPY run.sh /

RUN mkdir -p /notebooks/logs

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

VOLUME "/notebooks"

WORKDIR "/notebooks"

CMD ["sh", "/run.sh"]
