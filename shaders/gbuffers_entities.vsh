#version 330 compatibility

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;

void main() {
	gl_Position = ftransform();
	  gl_Position.xy /= 2.0;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}