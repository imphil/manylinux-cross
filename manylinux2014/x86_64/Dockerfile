FROM quay.io/pypa/manylinux2014_x86_64 AS manylinux

FROM ubuntu:20.04 AS toolchain

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    automake \
    bison \
    bzip2 \
    ca-certificates \
    cmake \
    curl \
    file \
    flex \
    g++ \
    gawk \
    gdb \
    git \
    gperf \
    help2man \
    libncurses-dev \
    libssl-dev \
    libtool-bin \
    make \
    ninja-build \
    patch \
    pkg-config \
    python3 \
    sudo \
    texinfo \
    unzip \
    wget \
    xz-utils \
    libssl-dev \
    libffi-dev

# Install crosstool-ng
RUN curl -Lf https://github.com/crosstool-ng/crosstool-ng/archive/02d1503f6769be4ad8058b393d4245febced459f.tar.gz | tar xzf - && \
    cd crosstool-ng-02d1503f6769be4ad8058b393d4245febced459f && \
    ./bootstrap && \
    ./configure --prefix=/usr/local && \
    make -j4 && \
    make install && \
    cd .. && rm -rf crosstool-ng-02d1503f6769be4ad8058b393d4245febced459f

COPY .config /tmp/toolchain.config

# Build cross compiler
RUN mkdir build && \
    cd build && \
    cp /tmp/toolchain.config .config && \
    export CT_ALLOW_BUILD_AS_ROOT_SURE=1 && \
    ct-ng build.2 && \
    cd .. && \
    rm -rf build

FROM ubuntu:20.04

# Copy cross toolchain
COPY --from=toolchain /usr/x86_64-unknown-linux-gnu /usr/x86_64-unknown-linux-gnu

ENV DEBIAN_FRONTEND noninteractive
ENV PATH=$PATH:/usr/x86_64-unknown-linux-gnu/bin

ENV CC_x86_64_unknown_linux_gnu=x86_64-unknown-linux-gnu-gcc \
    AR_x86_64_unknown_linux_gnu=x86_64-unknown-linux-gnu-ar \
    CXX_x86_64_unknown_linux_gnu=x86_64-unknown-linux-gnu-g++

ENV TARGET_CC=x86_64-unknown-linux-gnu-gcc \
    TARGET_AR=x86_64-unknown-linux-gnu-ar \
    TARGET_CXX=x86_64-unknown-linux-gnu-g++ \
    TARGET_READELF=x86_64-unknown-linux-gnu-readelf \
    TARGET_SYSROOT=/usr/x86_64-unknown-linux-gnu/x86_64-unknown-linux-gnu/sysroot/ \
    TARGET_C_INCLUDE_PATH=/usr/x86_64-unknown-linux-gnu/x86_64-unknown-linux-gnu/sysroot/usr/include/

ENV CARGO_BUILD_TARGET=x86_64-unknown-linux-gnu
ENV CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=x86_64-unknown-linux-gnu-gcc

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    curl \
    git \
    g++ \
    make \
    sudo \
    wget \
    software-properties-common \
    cmake \
    llvm-dev \
    libclang-dev \
    clang

# Target openssl & libffi
RUN export CC=$TARGET_CC && \
    echo "Building zlib" && \
    VERS=1.2.11 && \
    cd /tmp && \
    curl -sqLO https://zlib.net/zlib-$VERS.tar.gz && \
    tar xzf zlib-$VERS.tar.gz && cd zlib-$VERS && \
    ./configure --archs="-fPIC" --prefix=/usr/x86_64-unknown-linux-gnu/ || tail -n 500 configure.log && \
    make -j4 && make -j4 install && \
    cd .. && rm -rf zlib-$VERS.tar.gz zlib-$VERS && \
    echo "Building OpenSSL" && \
    VERS=1.1.1l && \
    curl -sqO https://www.openssl.org/source/openssl-$VERS.tar.gz && \
    tar xzf openssl-$VERS.tar.gz && cd openssl-$VERS && \
    ./Configure linux-generic32 -fPIC --prefix=/usr/x86_64-unknown-linux-gnu/ && \
    make -j4 && make -j4 install_sw install_ssldirs && \
    cd .. && rm -rf openssl-$VERS.tar.gz openssl-$VERS && \
    echo "Building libffi" && \
    VERS=3.3 && \
    curl -sqLO https://github.com/libffi/libffi/releases/download/v$VERS/libffi-$VERS.tar.gz && \
    tar xzf libffi-$VERS.tar.gz && cd libffi-$VERS && \
    ./configure --prefix=/usr/x86_64-unknown-linux-gnu/ --disable-docs --host=x86_64-unknown-linux-gnu --build=$(uname -m)-linux-gnu && \
    make -j4 && make -j4 install && \
    cd .. && rm -rf libffi-$VERS.tar.gz libffi-$VERS
ENV x86_64_UNKNOWN_LINUX_GNU_OPENSSL_DIR=/usr/x86_64-unknown-linux-gnu

RUN add-apt-repository -y ppa:deadsnakes/ppa && \
    add-apt-repository -y ppa:pypy/ppa && \
    apt-get update && \
    apt-get install -y \
    python3.6 python3.6-venv \
    python3.7 python3.7-venv \
    python3.9 python3.9-venv \
    python3.10 python3.10-venv \
    python3 python3-pip python3-venv python-is-python3 \
    pypy3

COPY --from=manylinux /opt/_internal /opt/_internal
COPY --from=manylinux /opt/python /opt/python

RUN python3 -m pip install --no-cache-dir auditwheel build && \
    python3 -m pip install --no-cache-dir maturin auditwheel-symbols patchelf
