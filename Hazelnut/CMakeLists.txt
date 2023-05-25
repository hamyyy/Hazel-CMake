cmake_minimum_required(VERSION 3.15)
project(Hazelnut)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/${PROJECT_NAME})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/${PROJECT_NAME})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/${PROJECT_NAME})

file(GLOB_RECURSE SOURCES
    src/*.h
    src/*.cpp
)

add_executable(${PROJECT_NAME} ${SOURCES})

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_SOURCE_DIR}/Hazel/vendor/spdlog/include
    ${CMAKE_SOURCE_DIR}/Hazel/src
    ${CMAKE_SOURCE_DIR}/Hazel/vendor
    ${IncludeDir_entt}
    ${IncludeDir_filewatch}
    ${IncludeDir_glm}
    ${IncludeDir_ImGuizmo}
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Hazel
)

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_compile_definitions(${PROJECT_NAME} PRIVATE
        HZ_DEBUG
    )
endif()

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