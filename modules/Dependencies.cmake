cmake_minimum_required(VERSION 3.15)
project(Hazel)

set(VULKAN_SDK $ENV{VULKAN_SDK})

set(IncludeDir)
set(IncludeDir_stb_image "${CMAKE_SOURCE_DIR}/Hazel/vendor/stb_image")
set(IncludeDir_yaml_cpp "${CMAKE_SOURCE_DIR}/Hazel/vendor/yaml-cpp/include")
set(IncludeDir_Box2D "${CMAKE_SOURCE_DIR}/Hazel/vendor/Box2D/include")
set(IncludeDir_filewatch "${CMAKE_SOURCE_DIR}/Hazel/vendor/filewatch")
set(IncludeDir_GLFW "${CMAKE_SOURCE_DIR}/Hazel/vendor/GLFW/include")
set(IncludeDir_Glad "${CMAKE_SOURCE_DIR}/Hazel/vendor/Glad/Glad/include")
set(IncludeDir_ImGui "${CMAKE_SOURCE_DIR}/Hazel/vendor/imgui/imgui")
set(IncludeDir_ImGuizmo "${CMAKE_SOURCE_DIR}/Hazel/vendor/ImGuizmo")
set(IncludeDir_glm "${CMAKE_SOURCE_DIR}/Hazel/vendor/glm")
set(IncludeDir_entt "${CMAKE_SOURCE_DIR}/Hazel/vendor/entt/include")
set(IncludeDir_mono "${CMAKE_SOURCE_DIR}/Hazel/vendor/mono/include")
set(IncludeDir_shaderc "${CMAKE_SOURCE_DIR}/Hazel/vendor/shaderc/include")
set(IncludeDir_SPIRV_Cross "${CMAKE_SOURCE_DIR}/Hazel/vendor/SPIRV-Cross")
set(IncludeDir_VulkanSDK "${VULKAN_SDK}/Include")


set(LibraryDir)

set(LibraryDir_VulkanSDK "${VULKAN_SDK}/Lib")
set(LibraryDir_mono "${CMAKE_SOURCE_DIR}/Hazel/vendor/mono/lib/%{cfg.buildcfg}") # TODO: fix this

set(Library)

set(Library_mono "${LibraryDir_mono}/libmono-static-sgen.lib")

set(Library_Vulkan "${LibraryDir_VulkanSDK}/vulkan-1.lib")
set(Library_VulkanUtils "${LibraryDir_VulkanSDK}/VkLayer_utils.lib")

set(Library_ShaderC_Debug "${LibraryDir_VulkanSDK}/shaderc_sharedd.lib")
set(Library_SPIRV_Cross_Debug "${LibraryDir_VulkanSDK}/spirv-cross-cored.lib")
set(Library_SPIRV_Cross_GLSL_Debug "${LibraryDir_VulkanSDK}/spirv-cross-glsld.lib")
set(Library_SPIRV_Tools_Debug "${LibraryDir_VulkanSDK}/SPIRV-Toolsd.lib")

set(Library_ShaderC_Release "${LibraryDir_VulkanSDK}/shaderc_shared.lib")
set(Library_SPIRV_Cross_Release "${LibraryDir_VulkanSDK}/spirv-cross-core.lib")
set(Library_SPIRV_Cross_GLSL_Release "${LibraryDir_VulkanSDK}/spirv-cross-glsl.lib")

# Windows
set(Library_WinSock "Ws2_32.lib")
set(Library_WinMM "Winmm.lib")
set(Library_WinVersion "Version.lib")
set(Library_BCrypt "Bcrypt.lib")
