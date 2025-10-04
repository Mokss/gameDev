shader_type spatial;

uniform vec4 color: source_color;
uniform sampler2D noise_txr: filter_nearest;
uniform sampler2D noise_txr2: filter_nearest;

void vertex() {
	vec3 txr_color = texture(noise_txr, UV + TIME * 0.05).rgb;
	VERTEX += txr_color * vec3(0.2, 0.2 , 0.2);
}

void fragment() {
	vec3 txr_color = texture(noise_txr, UV + TIME * 0.05).rgb;
	vec3 txr_color2 = texture(noise_txr2, UV + TIME * -0.05).rgb;
	vec3 final_color = color.rgb + (txr_color * txr_color2);
	ALBEDO = final_color;
	ALPHA = 0.8;
	ROUGHNESS = 0.0;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
