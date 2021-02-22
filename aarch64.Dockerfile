FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get install --no-install-recommends -y curl ca-certificates build-essential gcc-aarch64-linux-gnu libc6-arm64-cross libc6-dev-arm64-cross

RUN curl -L https://github.com/PyO3/maturin/releases/download/v0.9.4/maturin-x86_64-unknown-linux-musl.tar.gz | tar -C /usr/local/bin -xz

ENV TARGET_CC=aarch64-linux-gnu-gcc
ENV TARGET_CXX=aarch64-linux-gnu-cpp
ENV CARGO_BUILD_TARGET=aarch64-unknown-linux-gnu
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
