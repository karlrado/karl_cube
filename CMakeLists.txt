# Note: VULKAN_SDK must be set.
cmake_minimum_required(VERSION 3.5.1)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
project(karl_cube)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_COMPILER "/usr/bin/g++")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(GLSLANG_VALIDATOR "$ENV{VULKAN_SDK}/bin/glslangValidator")

find_package(Vulkan REQUIRED)
find_package(glfw3 3.3 REQUIRED)
include_directories(${Vulkan_INCLUDE_DIRS})

message(${Vulkan_INCLUDE_DIRS})
message(${Vulkan_LIBRARIES})
message(${Vulkan_LIBRARY})

add_executable(karl_cube main.cpp)

target_link_libraries(karl_cube ${Vulkan_LIBRARIES})
target_link_libraries(karl_cube glfw)

add_subdirectory(shaders)
add_dependencies(karl_cube generate-shaders)
