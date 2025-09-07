shader_type spatial;

uniform sampler2D my_texture;

void vertex() {
	//VERTEX.x += sin(TIME + VERTEX.y);
	VERTEX.x += sin(TIME * 10.0 + VERTEX.y * 10.) * 0.1;
}

void fragment() {
	vec2 adj_UV = UV * 1.5;
	vec2 original = vec2(UV);
	adj_UV.y += sin(original.x * 50.0 + TIME * 500.0) * 0.003;
	adj_UV.x += sin(original.y * 50.0 + TIME * 10.0) * 0.01;

    vec4 texture_color = texture(my_texture, adj_UV);

    ALBEDO = texture_color.rgb;
	//ALPHA = 0.3;
}
