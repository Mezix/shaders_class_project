shader_type spatial;
//render_mode ambient_light_disabled;
uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;
void vertex() {
	VERTEX = VERTEX;
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo, base_uv);
	ALBEDO = vec3(albedo_tex.r,albedo_tex.b,albedo_tex.b);
	// Called for every pixel the material is visible on.
	
}

void light() {
	// light we wish to accumulate
	DIFFUSE_LIGHT += ALBEDO * ATTENUATION * LIGHT_COLOR * max(dot(LIGHT,NORMAL), 0.0);

	// assign the result
	SPECULAR_LIGHT = round(DIFFUSE_LIGHT*16.0 - 0.5)/16.0; // posterizes the final color
	//SPECULAR_LIGHT = DIFFUSE_LIGHT; // do nothing to the result

	// cancel all contribution of the diffuse_light variable
	SPECULAR_LIGHT -= ALBEDO * DIFFUSE_LIGHT;
}
