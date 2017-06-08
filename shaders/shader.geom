#version 450

#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable


layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout (location = 0) out vec4 outColor;

void main() {
  for(int i = 0; i < gl_in.length(); i++) {
    gl_Position = gl_in[i].gl_Position;
    outColor = vec4(1.0, 0.5, 0.9, 1.0);
    EmitVertex();
  }
  EndPrimitive();
}
