# Minimum CMake required
cmake_minimum_required(VERSION 3.10)

# Project
project(vcpkg_build_test C CXX)

set(CMAKE_CXX_STANDARD 11)

set(STATIC_CRT OFF)

if (MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)

    if (STATIC_CRT)
        set(CompilerFlags
                CMAKE_CXX_FLAGS
                CMAKE_CXX_FLAGS_DEBUG
                CMAKE_CXX_FLAGS_RELEASE
                CMAKE_C_FLAGS
                CMAKE_C_FLAGS_DEBUG
                CMAKE_C_FLAGS_RELEASE
                )
        foreach(CompilerFlag ${CompilerFlags})
            string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
        endforeach()
    endif()
endif()

# add_subdirectory(v8)
add_subdirectory(antlr4)