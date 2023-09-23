shader_type canvas_item;

uniform sampler2D color_texture;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	float data = texture(SCREEN_TEXTURE, SCREEN_UV).r;
	COLOR = texture(color_texture, vec2(data, 0.0));
}
