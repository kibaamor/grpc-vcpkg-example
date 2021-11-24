find_package(Threads REQUIRED)
find_package(gRPC CONFIG REQUIRED)
find_package(protobuf CONFIG REQUIRED)

function(pbhelper)
    set(_options GEN_PB GEN_GRPC USE_ABSPATH)
    set(_singleargs TARGET OUT_DIR)
    set(_multiargs IMPORT_DIRS)

    cmake_parse_arguments(pbhelper "${_options}" "${_singleargs}" "${_multiargs}" "${ARGN}")

    if(NOT pbhelper_TARGET)
        message(SEND_ERROR "Error: pbhelper called without a target")
        return()
    endif()

    if(NOT pbhelper_OUT_DIR)
        set(pbhelper_OUT_DIR ${CMAKE_CURRENT_BINARY_DIR})
    endif()

    if(NOT pbhelper_GEN_PB AND NOT pbhelper_GEN_GRPC)
        message(SEND_ERROR "Error: pbhelper called without any action")
        return()
    else()
        target_include_directories(${pbhelper_TARGET}
            PUBLIC ${pbhelper_OUT_DIR}
        )
    endif()

    if(pbhelper_GEN_PB)
        if(pbhelper_USE_ABSPATH)
            protobuf_generate(
                APPEND_PATH
                TARGET ${pbhelper_TARGET}
                LANGUAGE cpp
                PROTOC_OUT_DIR ${pbhelper_OUT_DIR}
                IMPORT_DIRS ${pbhelper_IMPORT_DIRS}
            )
        else()
            protobuf_generate(
                TARGET ${pbhelper_TARGET}
                LANGUAGE cpp
                PROTOC_OUT_DIR ${pbhelper_OUT_DIR}
                IMPORT_DIRS ${pbhelper_IMPORT_DIRS}
            )
        endif()

        target_link_libraries(${pbhelper_TARGET}
            protobuf::libprotobuf
        )
    endif()

    if(pbhelper_GEN_GRPC)
        get_target_property(grpc_cpp_plugin_location gRPC::grpc_cpp_plugin LOCATION)

        if(pbhelper_USE_ABSPATH)
            protobuf_generate(
                APPEND_PATH
                TARGET ${pbhelper_TARGET}
                LANGUAGE grpc
                PROTOC_OUT_DIR ${pbhelper_OUT_DIR}
                IMPORT_DIRS ${pbhelper_IMPORT_DIRS}
                GENERATE_EXTENSIONS .grpc.pb.h .grpc.pb.cc
                PLUGIN "protoc-gen-grpc=${grpc_cpp_plugin_location}"
            )
        else()
            protobuf_generate(
                TARGET ${pbhelper_TARGET}
                LANGUAGE grpc
                PROTOC_OUT_DIR ${pbhelper_OUT_DIR}
                IMPORT_DIRS ${pbhelper_IMPORT_DIRS}
                GENERATE_EXTENSIONS .grpc.pb.h .grpc.pb.cc
                PLUGIN "protoc-gen-grpc=${grpc_cpp_plugin_location}"
            )
        endif()

        target_link_libraries(${pbhelper_TARGET}
            gRPC::grpc++
            gRPC::grpc++_reflection
        )
    endif()
endfunction(pbhelper)
