shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 white = vec4(1.0, 1.0, 1.0, previous_color.a);
	vec4 white_color = mix(previous_color, white, 0.6);
	if (active == true)
	{
		COLOR = white_color;
		
	} else{
		COLOR = previous_color;
	}
	//COLOR = new_color;
}