FROM ubuntu:18.04

RUN apt update
RUN apt install -y autoconf automake autotools-dev curl libmpc-dev \
  libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf \
  libtool patchutils bc zlib1g-dev libexpat-dev
RUN apt install -y git vim

ENV RISCV_URL=riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14
ENV PATH=/root/riscv_sifive_tools/$RISCV_URL/bin:$PATH
ENV LD_LIBRARY_PATH=/root/riscv_sifive_tools/$RISCV_URL/lib:$LD_LIBRARY_PATH


RUN mkdir -p $HOME/riscv_sifive_tools \
  && cd $HOME/riscv_sifive_tools \
  && curl -L https://static.dev.sifive.com/dev-tools/$RISCV_URL.tar.gz | tar xz

RUN apt install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev device-tree-compiler pkg-config libexpat-dev
ENV PATH=/root/riscv64_github/bin:$PATH
ENV RISCV=/root/riscv64_github
RUN cd /root \
  && git clone https://github.com/riscv-software-src/riscv-tools --recurse-submodules \
  && cd riscv-tools \
  && ./build.sh
# RUN cd /root \
#   && git clone https://github.com/ucb-bar/chipyard.git \
#   && cd chipyard \
#   && ./scripts/init-submodules-no-riscv-tools.sh
#   && MAKEFLAGS="-j16" ./scripts/build-toolchains.sh riscv-tools

ENV PATH=/root/cmake-3.24.0-rc2-linux-x86_64/bin:$PATH
RUN apt -y install ninja-build \
  && cd /root \
  && curl -L https://github.com/Kitware/CMake/releases/download/v3.24.0-rc2/cmake-3.24.0-rc2-linux-x86_64.tar.gz | tar xz \
  && git clone https://github.com/llvm/llvm-project.git -b release/12.x --depth 1 llvm-myriscv120 \
  && cd llvm-myriscv120 \
  && mkdir build \
  && cmake -G Ninja -DCMAKE_BUILD_TYPE="Debug" -DLLVM_TARGETS_TO_BUILD="X86;RISCV" -DLLVM_ENABLE_PROJECTS="clang;libcxx;libcxxabi" ../llvm \
  && ninja
