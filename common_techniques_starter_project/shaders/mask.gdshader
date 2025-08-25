shader_type canvas_item;

uniform sampler2D mask_texture;

void fragment() {
	vec4 mask_color = texture(mask_texture, UV);
	vec4 original_color = texture(TEXTURE, UV);

	if (original_color.a > 0.0) {
		COLOR.a = mask_color.r;
	}
	
	//COLOR = mask_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
