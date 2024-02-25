#version 150

in vec3 position;
in vec4 color;
out vec4 col;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

uniform int mode;
uniform float scale = 1.0, exponent = 1.0;
in vec3 p_center, p_up, p_down, p_left, p_right;
in vec4 smoothCol;
vec3 avgPos;
float outputColor;

void main()
{
  if (mode == 1){
    // outputColor <--- pow(y, exponent)
    // y <--  scale * pow(y, exponent)
    avgPos = vec3(p_center.x,(p_center.y + p_up.y + p_down.y + p_left.y + p_right.y) / 5.0f,p_center.z);
    outputColor = pow(avgPos.y,exponent);
    col = vec4(outputColor,outputColor,outputColor,1.0f);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(avgPos.x, scale * pow(avgPos.y,exponent), avgPos.z, 1.0f);
  } else {
    // compute the transformed and projected vertex position (into gl_Position) 
    // compute the vertex color (into col)
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0f);
    col = color;
  }
}

