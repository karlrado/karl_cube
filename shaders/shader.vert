#version 450

layout(location = 0) in vec3 inPosition;

layout(location = 0) out vec4 fragColor;

layout(binding = 0) uniform UniformBufferObject {
    mat4 mvp;
    mat4 view;
    mat4 proj;
    vec3 eye;
} ubo;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[];
    float gl_CullDistance[];
};

void main() {
    gl_Position = ubo.mvp * vec4(inPosition, 1.0);
    fragColor = vec4(120.0f/255.0f, 43.0f/255.0f, 144.0f/255.0f, 1.0);
}
