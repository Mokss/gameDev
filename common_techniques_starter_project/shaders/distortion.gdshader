shader_type canvas_item;

uniform vec2 offset1 = vec2(0.2);
uniform sampler2D noise_text1: repeat_enable;
uniform vec2 offset2 = vec2(0.1);
uniform sampler2D noise_text2: repeat_enable;

void fragment() {
	vec4 noice_color1 = texture(noise_text1, UV + offset1 * TIME);
	vec4 noice_color2 = texture(noise_text1, UV + offset2 * TIME);
	
	float final_noise = noice_color1.r * noice_color2.r;
	vec4 final_color = vec4(vec3(final_noise), 1.0);
	
	COLOR = final_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
