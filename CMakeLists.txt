cmake_minimum_required(VERSION 3.15)
project(Hazel)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/modules")

# Dependencies.cmake in modules folder
include(Dependencies)

set(CMAKE_GENERATOR_PLATFORM x64)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Dependencies
add_subdirectory(Hazel/vendor/Box2D)
add_subdirectory(Hazel/vendor/GLFW)
add_subdirectory(Hazel/vendor/Glad)
add_subdirectory(Hazel/vendor/imgui)
add_subdirectory(Hazel/vendor/yaml-cpp)

# Core
add_subdirectory(Hazel)

# Tools
# add_subdirectory(Hazelnut)

# Misc
add_subdirectory(Sandbox)