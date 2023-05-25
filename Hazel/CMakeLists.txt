cmake_minimum_required(VERSION 3.15)
project(Hazel)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/${PROJECT_NAME})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/${PROJECT_NAME})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/${PROJECT_NAME})

option(BOX2D_BUILD_UNIT_TESTS "Build the Box2D unit tests" OFF)
option(BOX2D_BUILD_TESTBED "Build the Box2D testbed" OFF)
option(BOX2D_BUILD_DOCS "Build the Box2D documentation" OFF)
option(BOX2D_USER_SETTINGS "Override Box2D settings with b2UserSettings.h" OFF)
option(BUILD_SHARED_LIBS "Build Box2D as a shared library" ON)

file(GLOB_RECURSE HAZEL_HEADERS
    src/*.h
    vendor/stb_image/*.h
    vendor/glm/glm/*.hpp
    vendor/ImGuizmo/ImGuizmo.h
)

file(GLOB_RECURSE HAZEL_SOURCES
    src/*.cpp
    vendor/stb_image/*.cpp
    vendor/glm/glm/*.inl
    vendor/ImGuizmo/ImGuizmo.cpp
)

add_library(${PROJECT_NAME} STATIC ${HAZEL_HEADERS} ${HAZEL_SOURCES})

target_precompile_headers(${PROJECT_NAME} PRIVATE src/hzpch.h)

target_compile_definitions(${PROJECT_NAME} PRIVATE
    _CRT_SECURE_NO_WARNINGS
    GLFW_INCLUDE_NONE
)

target_include_directories(${PROJECT_NAME} PRIVATE
    src
    vendor/spdlog/include
    ${IncludeDir_Box2D}
    ${IncludeDir_filewatch}
    ${IncludeDir_GLFW}
    ${IncludeDir_Glad}
    ${IncludeDir_ImGui}
    ${IncludeDir_glm}
    ${IncludeDir_stb_image}
    ${IncludeDir_entt}
    ${IncludeDir_mono}
    ${IncludeDir_yaml_cpp}
    ${IncludeDir_ImGuizmo}
    ${IncludeDir_VulkanSDK}
)

message("IncludeDir_VulkanSDK: ${IncludeDir_VulkanSDK}")

target_link_libraries(${PROJECT_NAME} PRIVATE
    box2d
    glfw
    glad
    imgui
    yaml-cpp
    opengl32.lib
    # ${Library_mono}
)

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_link_libraries(${PROJECT_NAME} PRIVATE
        ${Library_WinSock}
        ${Library_WinMM}
        ${Library_WinVersion}
        ${Library_BCrypt}
    )
endif()

target_compile_options(${PROJECT_NAME} PRIVATE
    $<$<COMPILE_LANGUAGE:CXX>:/EHsc>
)

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_definitions(${PROJECT_NAME} PRIVATE HZ_DEBUG)
    target_compile_options(${PROJECT_NAME} PRIVATE /Od /Zi)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        ${Library_ShaderC_Debug}
        ${Library_SPIRV_Cross_Debug}
        ${Library_SPIRV_Cross_GLSL_Debug}
    )
elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
    target_compile_definitions(${PROJECT_NAME} PRIVATE HZ_RELEASE)
    target_compile_options(${PROJECT_NAME} PRIVATE /O2)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        ${Library_ShaderC_Release}
        ${Library_SPIRV_Cross_Release}
        ${Library_SPIRV_Cross_GLSL_Release}
    )
elseif (CMAKE_BUILD_TYPE STREQUAL "Dist")
    target_compile_definitions(${PROJECT_NAME} PRIVATE HZ_DIST)
    target_compile_options(${PROJECT_NAME} PRIVATE /O2)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        ${Library_ShaderC_Release}
        ${Library_SPIRV_Cross_Release}
        ${Library_SPIRV_Cross_GLSL_Release}
    )
endif()