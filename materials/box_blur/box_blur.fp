#version 420

precision highp float;

in vec2 var_texcoord0;

uniform sampler2D color_sampler;

uniform box_blur_fp {
	vec4 params;
};

vec2 resolution	= textureSize(color_sampler, 0);
vec2 delta		= params.xy / resolution;

layout(location = 0) out vec4 fragColor;

void main() {

	vec3 result = texture(color_sampler, var_texcoord0).rgb;
	float total = 1;
	for (int i = 1; i < 20; ++i) {
		result += texture(color_sampler, var_texcoord0 + delta * i).rgb;
		result += texture(color_sampler, var_texcoord0 - delta * i).rgb;
		total += 2;
	}
	fragColor = vec4(result / total, 1.0);
}
