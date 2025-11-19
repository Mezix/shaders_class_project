shader_type canvas_item;

// --- Uniforms --- //
uniform bool weighted = true;	// Determines whether to use normal or weighted averages
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	float gray_scale_val = (texture(screen_texture, SCREEN_UV).r + texture(screen_texture, SCREEN_UV).g + texture(screen_texture, SCREEN_UV).b) /3.0;
    //vec3 color;
	//color.r = texture(screen_texture, SCREEN_UV).r;
	//color.g = texture(screen_texture, SCREEN_UV).g;
	//color.b = texture(screen_texture, SCREEN_UV).b;
	COLOR = vec4(vec3(gray_scale_val),1.0);
	}