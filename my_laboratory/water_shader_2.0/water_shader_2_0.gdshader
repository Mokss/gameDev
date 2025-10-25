shader_type spatial;

uniform vec4 color: source_color;
uniform sampler2D noise_txr: filter_nearest;
uniform sampler2D noise_txr2: filter_nearest;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;
uniform float fade_distance = 1.00;

void vertex() {
	vec3 txr_color = texture(noise_txr, UV + TIME * 0.1).rgb;
	VERTEX += txr_color * vec3(0, 0.5, 0);
}

void fragment() {
	//ProximityFade
	// опираяемся на текстуру глубины и координаты объекта в глубину
	float scene_depth = texture(DEPTH_TEXTURE, SCREEN_UV).r;
	vec4 depth_world_pos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, scene_depth, 1.0);
	depth_world_pos.xyz /= depth_world_pos.w;
	float fade = clamp(1.0 - smoothstep(depth_world_pos.z + fade_distance, depth_world_pos.z, VERTEX.z), 0.0, 1.0);
	fade = 1.0 - fade;

	float min_foam = pow(fade, 24);
	float foam = abs(sin((TIME * 0.5 + fade) * 4.0)) * fade + min_foam;

	vec3 txr_color = texture(noise_txr, UV + TIME * 0.05).rgb;
	vec3 txr_color2 = texture(noise_txr2, UV + TIME * -0.05).rgb;
	vec3 tmp = txr_color * txr_color2;
	vec3 powvec = pow(tmp, vec3(1.2));
	vec3 final_color = color.rgb + powvec + foam;
	ALBEDO = final_color;
	EMISSION = powvec;
	ALPHA = 0.8;
	ROUGHNESS = 0.0;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
