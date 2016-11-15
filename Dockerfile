FROM tensorflow/tensorflow:0.11.0

MAINTAINER masakiz

RUN apt-get update && apt-get install -y \
    wget \
    git \
    libpq-dev \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip && \
    pip --no-cache-dir install \
    pandas \
    statsmodels \
    scikit-learn \
    seaborn \
    psycopg2 \
    sympy

COPY run.sh /

RUN mkdir -p /notebooks/logs

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

VOLUME "/notebooks"

WORKDIR "/notebooks"

CMD ["sh", "/run.sh"]
