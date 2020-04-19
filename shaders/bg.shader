shader_type canvas_item;

uniform float offsetx:hint_range(0.0, 1.0)=0.0;
uniform float offsety:hint_range(0.0, 1.0)=0.0;

void fragment(){
    vec2 newuv = UV;
	ivec2 size=textureSize(TEXTURE,0);
    newuv.x += offsetx;
	newuv.y += offsety;
    vec4 c = texture(TEXTURE, newuv);
    COLOR = c;
}