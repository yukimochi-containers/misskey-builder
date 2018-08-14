FROM node:slim

ENV NODE_ENV production

WORKDIR /misskey

RUN apt-get update && \
    apt-get -y install --no-install-recommends build-essential cmake git python && \
    cd ~ && \
    git clone https://github.com/google/brotli.git && \
    cd brotli && \
    mkdir out && \
    cd out && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=./installed .. && \
    cmake --build . --config Release --target install && \
    cp installed/bin/brotli /usr/local/bin/ && \
    apt-get -y remove --purge cmake && \
    apt-get -y autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc -q -O /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc
