shader_type spatial;
render_mode unshaded;
uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo, base_uv);
	//ALBEDO = ((0.2126*albedo.r + 0.7152*albedo.g + albedo.b)) * albedo_tex.rgb;
	//float val = texture_albedo; //(albedo.r + albedo.g + albedo.b) /3.0;
	float val = (albedo.r * albedo_tex.r + albedo.g * albedo_tex.g + albedo.b * albedo_tex.b ) /3.0;
	//val = (albedo.r + albedo.g + albedo.b) /3.0;
	ALBEDO = vec3(val,val,val);
	// Called for every pixel the material is visible on.
}