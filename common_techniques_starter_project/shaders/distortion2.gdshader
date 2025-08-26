shader_type canvas_item;

uniform float distortion_streng: hint_range(0.0, 0.1) = 0.02;
uniform vec2 offset1 = vec2(0.2);
uniform sampler2D noise_text1: repeat_enable;
uniform vec2 offset2 = vec2(0.1);
uniform sampler2D noise_text2: repeat_enable;
uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;

void fragment() {
	vec4 noice_color1 = texture(noise_text1, UV + offset1 * TIME);
	vec4 noice_color2 = texture(noise_text1, UV + offset2 * TIME);

	float final_noise = noice_color1.r * noice_color2.r;
	vec4 final_color = texture(screen_texture, SCREEN_UV + final_noise * distortion_streng);

	COLOR = final_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
