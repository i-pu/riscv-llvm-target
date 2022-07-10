help:
    echo "spike pk a.out"
    echo "spike -l pk a.out"

help-docker:
  echo "docker run -i -t --rm -v $(pwd)/llvm-project:/root/llvm-project riscv-llvm-target"
  echo "docker exec -i -t hogehoge bash"

# cmake -G Ninja -DCMAKE_BUILD_TYPE="Debug" \
# -DLLVM_TARGETS_TO_BUILD="X86;RISCV" \
# -DLLVM_ENABLE_PROJECTS="clang;libcxx;libcxabi" \
# ../llvm

