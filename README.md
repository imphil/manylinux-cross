# manylinux-cross

[![manylinux2014 Docker Image](https://img.shields.io/docker/pulls/messense/manylinux2014-cross.svg?maxAge=2592000&label=manylinux2014)](https://hub.docker.com/r/messense/manylinux2014-cross/)
[![manylinux_2_24 Docker Image](https://img.shields.io/docker/pulls/messense/manylinux_2_24-cross.svg?maxAge=2592000&label=manylinux_2_24)](https://hub.docker.com/r/messense/manylinux_2_24-cross/)
[![Build](https://github.com/messense/manylinux-cross/workflows/Build/badge.svg)](https://github.com/messense/manylinux-cross/actions?query=workflow%3ABuild)
[![Test](https://github.com/messense/manylinux-cross/workflows/Test/badge.svg)](https://github.com/messense/manylinux-cross/actions?query=workflow%3ATest)

manylinux2014 and manylinux_2_24 aarch64/armv7l/s390x/ppc64/ppc64le cross compilation docker images,
supports both x86_64(amd64) and aarch64(arm64) architectures.

| Architecture |      OS      |            Image                |      Tag        |        GCC          |           Target Python                     |       Host Python      |
| ------------ | ------------ | ------------------------------- | --------------- | ------------------- | ------------------------------------------- | ---------------------- |
| x86_64       | Ubuntu 20.04 | [messense/manylinux2014-cross]  | x86_64          | 4.8.5               |  Copied from manylinux2014_x86_64           | Python 3.6 - 3.10      |
| i686         | Ubuntu 20.04 | [messense/manylinux2014-cross]  | i686            | 4.8.5               |  Copied from manylinux2014_i686             | Python 3.6 - 3.10      |
| aarch64      | Ubuntu 20.04 | [messense/manylinux2014-cross]  | aarch64         | 4.8.5               |  Copied from manylinux2014_aarch64          | Python 3.6 - 3.10      |
| aarch64      | Ubuntu 20.04 | [messense/manylinux_2_24-cross] | aarch64         | 6.5.0               |  Copied from manylinux_2_24_aarch64         | Python 3.6 - 3.10      |
| armv7l       | Ubuntu 20.04 | [messense/manylinux2014-cross]  | armv7l / armv7  | 4.8.5               |  `/opt/python/cp3[6-10]`, built from source | Python 3.6 - 3.10      |
| armv7l       | Ubuntu 20.04 | [messense/manylinux_2_24-cross] | armv7l / armv7  | 6.5.0               |  `/opt/python/cp3[6-10]`, built from source | Python 3.6 - 3.10      |
| s390x        | Ubuntu 20.04 | [messense/manylinux2014-cross]  | s390x           | 4.8.5               |  Copied from manylinux2014_s390x            | Python 3.6 - 3.10      |
| s390x        | Ubuntu 20.04 | [messense/manylinux_2_24-cross] | s390x           | 6.5.0               |  Copied from manylinux_2_24_s390x           | Python 3.6 - 3.10      |
| ppc64        | Ubuntu 20.04 | [messense/manylinux2014-cross]  | ppc64           | 4.8.5               |  `/opt/python/cp3[6-10]`, built from source | Python 3.6 - 3.10      |
| ppc64le      | Ubuntu 20.04 | [messense/manylinux2014-cross]  | ppc64le         | 4.8.5               |  Copied from manylinux2014_ppc64le          | Python 3.6 - 3.10      |
| ppc64le      | Ubuntu 20.04 | [messense/manylinux_2_24-cross] | ppc64le         | 6.5.0               |  Copied from manylinux_2_24_ppc64le         | Python 3.6 - 3.10      |

Target cross compilers and [maturin](https://github.com/PyO3/maturin) are installed in the image.

## Environment variables

Following list of environment variables are set:

* `TARGET_CC`
* `TARGET_CXX`
* `TARGET_AR`
* `TARGET_SYSROOT`
* `TARGET_C_INCLUDE_PATH`
* `CARGO_BUILD_TARGET`
* `CARGO_TARGET_${target}_LINKER`
* `${target}_OPENSSL_DIR`

[messense/manylinux2014-cross]: https://hub.docker.com/r/messense/manylinux2014-cross
[messense/manylinux_2_24-cross]: https://hub.docker.com/r/messense/manylinux_2_24-cross
