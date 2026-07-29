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
	float texel_uv_x = floor(SCREEN_UV.x*640.0)/640.0;
	float texel_uv_y = floor(SCREEN_UV.y*360.0)/360.0;
	
	vec2 texel_uv = SCREEN_UV + vec2(sin(TIME/1.5)*.01, cos(TIME/1.5)*.01);
	
	vec4 color = texture(screen_texture, texel_uv);
	
	ALBEDO = color.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
