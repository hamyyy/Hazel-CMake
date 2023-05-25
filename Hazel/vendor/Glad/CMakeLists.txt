cmake_minimum_required(VERSION 3.0)
project(Glad)

add_library(glad STATIC Glad/include/glad/glad.h Glad/src/glad.c)
target_include_directories(glad PUBLIC glad/include/)