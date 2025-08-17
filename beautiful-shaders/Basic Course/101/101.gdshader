shader_type canvas_item;

group_uniforms FirstGourp;
uniform float my_float: hint_range(1.0, 10.0) = 5.0;
uniform int my_int = 4;
group_uniforms;

uniform bool my_bool = false;
uniform int my_range_int: hint_range(1, 100, 1);
uniform float my_range_float: hint_range(1.0, 100.0) = 5.0;
uniform vec4 my_color: source_color;

void vertex() {
    if (VERTEX.y < 0.0) {
        // круговая анимация
        vec2 circle = vec2(sin(TIME * my_float), cos(TIME * my_float)) * 50.0;

        // базовое смещение: -50 для левой, +50 для правой
        float side = VERTEX.x < 0.0 ? -1.0 : 1.0;
        VERTEX += vec2(50.0 * side, 0.0) + vec2(circle.x * side, circle.y);
    }
}

void fragment() {
	vec4 color1 = vec4(1.0, 0.0, 0.0, 1.0);
	vec4 color2 = vec4(0.0, 1.0, 0.1, 1.0);

	float mix_pct = (sin(TIME) + 1.0) * 0.5;
	vec4 mixed_color = mix(color1, color2, mix_pct);
	COLOR = texture(TEXTURE, UV) * mixed_color;
	//COLOR = my_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
