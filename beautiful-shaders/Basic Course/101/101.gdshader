shader_type canvas_item;

void vertex() {
    if (VERTEX.y < 0.0) {
        // круговая анимация
        vec2 circle = vec2(sin(TIME), cos(TIME)) * 50.0;

        // базовое смещение: -50 для левой, +50 для правой
        float side = VERTEX.x < 0.0 ? -1.0 : 1.0;
        VERTEX += vec2(50.0 * side, 0.0) + vec2(circle.x * side, circle.y);
		//UV += vec2(circle.x * side / 50.0, circle.y / 50.0);
    }
}

void fragment() {
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
