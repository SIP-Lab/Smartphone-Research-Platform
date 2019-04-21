cmake_minimum_required(VERSION 3.4.1)

file(GLOB C_FILES "*.c")

add_library(Algorithm SHARED
            Algorithm.c
            ${C_FILES})

target_link_libraries(Algorithm
                      android
                      log)