FROM tensorflow/tensorflow:1.0.0-py3

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
    keras \
    h5py \
    Cython \
    gensim \
    PyAthenaJDBC \
    selenium
RUN pip --no-cache-dir install word2vec

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
