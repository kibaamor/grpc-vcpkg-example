foreach(_target
    greeter_client greeter_server
    greeter_callback_client greeter_callback_server
    greeter_async_client greeter_async_client2 greeter_async_server)

    add_executable(${_target} "${_target}.cc")
    target_link_libraries(${_target}
        api_lib)
endforeach()
