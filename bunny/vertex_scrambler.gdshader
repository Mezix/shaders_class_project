shader_type spatial;

uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;

void vertex() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo, base_uv);
	VERTEX = VERTEX + NORMAL * (0.5 + cos(TIME * 5.0)) * 0.01;
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
