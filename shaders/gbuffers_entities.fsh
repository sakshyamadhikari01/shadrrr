#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;
uniform vec4 entityColor;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 normal;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
		// figure out how much this face points upward
	float upFacing = clamp(normal.y, 0.0, 1.0);

	// bright top, darker bottom
	vec3 topColor    = color.rgb * 1.5;
	vec3 bottomColor = color.rgb * 0.6;
	color.rgb = mix(bottomColor, topColor, upFacing);

	// soften the alpha for natural blending
	color.a = pow(color.a, 0.75);

	color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);
	color *= texture(lightmap, lmcoord);
	  color.r = 1.0;
	if (color.a < alphaTestRef) {
		discard;
	}
}