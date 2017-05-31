cmake_minimum_required(VERSION 3.5.1)

add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/shaders/vert.spv
    COMMAND ${GLSLANG_VALIDATOR} -s -V -o ${CMAKE_BINARY_DIR}/shaders/vert.spv ${PROJECT_SOURCE_DIR}/shaders/shader.vert
    DEPENDS ${PROJECT_SOURCE_DIR}/shaders/shader.vert ${GLSLANG_VALIDATOR}
    )
add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/shaders/frag.spv
    COMMAND ${GLSLANG_VALIDATOR} -s -V -o ${CMAKE_BINARY_DIR}/shaders/frag.spv ${PROJECT_SOURCE_DIR}/shaders/shader.frag
    DEPENDS ${PROJECT_SOURCE_DIR}/shaders/shader.frag ${GLSLANG_VALIDATOR}
    )
add_custom_target(generate-shaders DEPENDS ${CMAKE_BINARY_DIR}/shaders/vert.spv ${CMAKE_BINARY_DIR}/shaders/frag.spv)
