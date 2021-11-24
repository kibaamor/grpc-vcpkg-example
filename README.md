# grpc-vcpkg-example

A basic example for using gRPC by vcpkg.

## Environment setup

```bash
# download and setup vcpkg
git clone https://github.com/microsoft/vcpkg
cd vcpkg
./bootstrap-vcpkg.sh -disableMetrics

# install protobuf and gRPC
./vcpkg install grpc
./vcpkg install protobuf

# export environment variable VCPKG_ROOT
export VCPKG_ROOT=`pwd`
```

## Compile example

```bash
git clone https://github.com/kibaamor/grpc-vcpkg-example
mkdir grpc-vcpkg-example/build
cd grpc-vcpkg-example/build
cmake ..
make -j `nproc`
```
