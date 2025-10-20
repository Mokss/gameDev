shader_type spatial;

render_mode cull_disabled, depth_draw_opaque;

uniform vec3 spehere_color: source_color = vec3(0.0, 0.0, 0.0);
uniform vec3 clip_normal = vec3(1.0, 0.0, 0.0);

varying vec3 v_local_pos;

void vertex() {
    v_local_pos = VERTEX;
}

void fragment() {
    float side = dot(normalize(clip_normal), v_local_pos);

    if (side < 0.0) {
        discard;
    }

	ALBEDO = spehere_color;
}
