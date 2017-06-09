#version 450

#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
    vec3 eye;
} ubo;

layout(lines_adjacency) in;
layout(line_strip, max_vertices = 2) out;

in vec4 inColor[];
layout (location = 0) out vec4 outColor;

void main() {
  // Calculate two vectors in the plane of the input face.
  // The input is line adjacency, which means that we get
  // four verts, with the acutal line segment being in [1] and [2].
  // All four verts are in the same plane, so it does not matter
  // which three we pick to make the two vectors.
  vec3 ab = gl_in[0].gl_Position.xyz - gl_in[1].gl_Position.xyz;
  vec3 ac = gl_in[0].gl_Position.xyz - gl_in[2].gl_Position.xyz;
  vec3 face_normal = normalize(cross(ab, ac));

  // Transform the eye point into the projection space.
  vec4 eye = ubo.proj * vec4(ubo.eye, 1.0f);
  eye = eye * (1.0f / eye[3]);

  // Calculate the view direction vector
  vec3 vt = normalize(eye.xyz) - gl_in[1].gl_Position.xyz;

  // Take the dot product of the normal with the view direction
  float d = dot(vt, face_normal);

  if (d > 0) {
    gl_Position = gl_in[1].gl_Position;
    outColor = inColor[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outColor = inColor[2];
    EmitVertex();
    EndPrimitive();
  }
}
