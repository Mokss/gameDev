shader_type spatial;

render_mode cull_disabled, diffuse_lambert_wrap;
//render_mode cull_disabled, diffuse_toon;

uniform vec3 base_color: source_color = vec3(0.592, 0.447, 0.0);
uniform vec3 grass_color: source_color = vec3(0.51, 0.57, 0.);
uniform float grass_height_mult: hint_range(0.0, 3.0, 0.1) = 1.0;
uniform sampler2D wind_noise: repeat_enable, filter_linear;

void vertex() {
	vec2 UV_Offset = (NODE_POSITION_WORLD.xy + TIME) * 0.01;
	float UV_Y = (1.0 - UV.y) * grass_height_mult; 
	
	vec4 wind_coords = texture(wind_noise, UV + UV_Offset);
	vec3 vertex_add_coords = wind_coords.xyz * UV_Y;
	
	
	VERTEX += vertex_add_coords;
}

void fragment() {
	float UV_Y = 1.0 - UV.y; 
	vec3 final_color = mix(base_color,grass_color, UV_Y);

	ALBEDO = final_color;


	
	NORMAL_MAP = vec3(0, 1, 0);
	//NORMAL = vec3(0, 1, 0);
	ROUGHNESS = 0.5;
	METALLIC = 0.0;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
