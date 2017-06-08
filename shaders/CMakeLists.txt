cmake_minimum_required(VERSION 3.5.1)

set(DEPS)
set(SHADER_SOURCES)

macro(build_shader src dst)
    add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/shaders/${dst}
        COMMAND ${GLSLANG_VALIDATOR} -s -V -o ${CMAKE_BINARY_DIR}/shaders/${dst} ${PROJECT_SOURCE_DIR}/shaders/${src}
        DEPENDS ${PROJECT_SOURCE_DIR}/shaders/${src} ${GLSLANG_VALIDATOR}
        )
    set(DEPS ${DEPS} ${CMAKE_BINARY_DIR}/shaders/${dst})
    set(SHADER_SOURCES ${SHADER_SOURCES} ${src})
endmacro(build_shader)

build_shader("shader.vert" "vert.spv")
build_shader("shader.frag" "frag.spv")

add_custom_target(generate-shaders DEPENDS ${DEPS})
add_custom_target(shaders SOURCES ${SHADER_SOURCES})
