shader_type spatial;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;

void vertex() {

	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo, base_uv);
	ALBEDO = vec3(1,1,1) - (albedo.rgb * albedo_tex.rgb);
	// Called for every pixel the material is visible on.
}