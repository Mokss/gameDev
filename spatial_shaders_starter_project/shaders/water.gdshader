shader_type spatial;

uniform sampler2D normalmap_tex1: repeat_enable, filter_linear;
uniform sampler2D normalmap_tex2: repeat_enable, filter_linear;
uniform vec3 albedo: source_color = vec3(1.0);
uniform vec2 direction1 = vec2(1.0, 0.0);
uniform float scroll_speed1: hint_range(0.0, 1.0) = 0.1;
uniform vec2 direction2 = vec2(1.0, 0.0);
uniform float scroll_speed2: hint_range(0.0, 1.0) = 0.1;

void fragment() {
	vec2 offset1 = scroll_speed1 * direction1 * TIME;
	vec3 normal_map1 = texture(normalmap_tex1, UV * 2.0 + offset1).rgb;
	vec2 offset2 = scroll_speed2 * direction2 * TIME;
	vec3 normal_map2 = texture(normalmap_tex2, UV * 2.0 + offset2).rgb;

	NORMAL_MAP = mix(normal_map1, normal_map2, 0.5);
	ALBEDO = albedo;
	METALLIC = 0.0;
	ROUGHNESS = 0.001;
}


