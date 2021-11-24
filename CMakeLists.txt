cmake_minimum_required(VERSION 3.11)

if(DEFINED ENV{VCPKG_ROOT})
    set(CMAKE_TOOLCHAIN_FILE $ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)
else()
    set(CMAKE_TOOLCHAIN_FILE "~/repos/vcpkg/scripts/buildsystems/vcpkg.cmake")
endif()

project(grpc-vcpkg-example CXX)

include(cmake/pbhelper.cmake)

add_subdirectory(api)
add_subdirectory(src)
