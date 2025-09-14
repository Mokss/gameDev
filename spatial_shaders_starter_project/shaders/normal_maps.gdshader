shader_type spatial;

uniform sampler2D normalmap_tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 normal_map = texture(normalmap_tex, UV * 10.0).rgb;

	NORMAL_MAP = normal_map;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
