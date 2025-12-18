shader_type spatial;

//render_mode ambient_light_disabled;
uniform vec4 albedo_tex : source_color;
uniform sampler2D _MainTex : source_color, filter_linear_mipmap, repeat_enable;
uniform sampler2D _NormalMap : hint_normal;
uniform float _Scale : hint_range(-16.0, 16.0, 0.1);

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
	vec3 albedo = texture(_MainTex, UV).rgb;
	vec3 normal_map = texture(_NormalMap, UV).rgb;
	normal_map = normal_map * 2.0 - 1.0;
	normal_map *= _Scale;
	mat3 TBN = mat3(TANGENT.xyz, BINORMAL.xyz, NORMAL.xyz);
	vec3 normal_vs = normalize(TBN * normal_map);
	float n_z = clamp(dot(normal_map.xy, normal_map.xy), 0.0, 1.0);
	normal_map.z = sqrt(1.0 - n_z);
	
	
	// Called for every pixel the material is visible on.
	ALBEDO = albedo;
	NORMAL_MAP_DEPTH = 1.0;
	NORMAL = normal_vs;
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