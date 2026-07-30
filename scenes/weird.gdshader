shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float texel_size : hint_range(0.0, 1.0, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	float x_pixellate = 512.0;
	float y_pixellate = 512.0;
	
	vec2 offset_uv = SCREEN_UV + vec2(sin(TIME/1.5)*.01, cos(TIME/1.5)*.01);
	
	vec2 center = vec2(.5, .5);
	
	vec2 dist = abs(center - offset_uv);
	
	
	x_pixellate *= smoothstep(.7,.3,dist.x);
	y_pixellate *= smoothstep(.7,.3,dist.y);

	
	float texel_uv_x = floor(offset_uv.x*x_pixellate)/(x_pixellate);
	float texel_uv_y = floor(offset_uv.y*y_pixellate)/(y_pixellate);
	
	vec2 texel_uv = vec2(texel_uv_x, texel_uv_y);
	
	vec4 color = texture(screen_texture, texel_uv);
	
	ALBEDO = color.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
