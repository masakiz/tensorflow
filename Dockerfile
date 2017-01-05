FROM tensorflow/tensorflow:0.12.1

MAINTAINER masakiz

RUN apt-get update && apt-get install -y \
    wget \
    git \
    libpq-dev \
    xclip \
    python-dev \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    && \
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
    keras

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
