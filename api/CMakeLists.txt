file(GLOB api_list "*.proto")

# create a static library for all gRPC sources
add_library(api_lib)

# add proto files
target_sources(api_lib
    PRIVATE ${api_list}
)

pbhelper(
    GEN_PB
    GEN_GRPC
    USE_ABSPATH
    TARGET api_lib
    OUT_DIR ${CMAKE_CURRENT_BINARY_DIR}
    IMPORT_DIRS ${CMAKE_CURRENT_SOURCE_DIR}
)
