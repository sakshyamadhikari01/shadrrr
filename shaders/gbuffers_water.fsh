#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
		// Add water color and effects
	color.rgb = mix(color.rgb, vec3(0.2, 0.5, 0.8), 0.3);
	color.rgb *= 1.2;
	color.a = 0.7;

	if (color.a < alphaTestRef) {
		discard;
	}
}