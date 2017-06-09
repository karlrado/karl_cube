#version 450

#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
} ubo;

layout(lines_adjacency) in;
layout(line_strip, max_vertices = 10) out;

in vec4 inColor[];
in vec3 inNormal[];
layout (location = 0) out vec4 outColor;

void main() {
  // Calculate two vectors in the plane of the input triangle
  vec3 ab = gl_in[0].gl_Position.xyz - gl_in[1].gl_Position.xyz;
  vec3 ac = gl_in[0].gl_Position.xyz - gl_in[2].gl_Position.xyz;
  vec3 normal = normalize(cross(ab, ac));

  // Calculate the transformed face normal and the view direction vector
  vec3 vt = normalize(gl_in[1].gl_Position.xyz - vec3(2.0f,2.0f,2.0f));

  // Take the dot product of the normal with the view direction
  float d = dot(vt, normal);

  if (d > 0) {
    for(int i = 0; i < gl_in.length(); i++) {
      gl_Position = gl_in[i].gl_Position;
      outColor = inColor[i];
      EmitVertex();
    }
    EndPrimitive();
  }
}
