shader_type spatial;

//render_mode ambient_light_disabled;
uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;

float lambert(float i, vec3 l, vec3 n)
{
	return max(0.0, dot(n, l)) * i;
}
float phong(vec3 v, vec3 l, vec3 n, float m)
	{
	vec3 r = reflect(-l, n);
	return pow(max(0.0, dot(r, v)), m);
}
float blinn_phong(vec3 v, vec3 l, vec3 n, float m)
{
	vec3 h = normalize(l + v);
	float s = pow(max(0.0, dot(n, h)), m);
	s *= float(dot(n, l) > 0.0);
	return s;
}

void vertex() {
	// Called for every vertex the material is visible on.
}
void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo, base_uv);
	ALBEDO = vec3(albedo_tex.r,albedo_tex.b,albedo_tex.b);
	// Called for every pixel the material is visible on.

}
void light()
{
	float i = ATTENUATION;
	vec3 l = LIGHT;
	vec3 n = NORMAL;
	vec3 v = VIEW;

	float d = lambert(i, l, n);
	//float s = phong(v, l, n, 64.0);
	float s = blinn_phong(v, l, n, 64.0);

	DIFFUSE_LIGHT += vec3(d) * 0.3;
	SPECULAR_LIGHT += vec3(s);
}