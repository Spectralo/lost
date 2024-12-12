shader_type canvas_item;

uniform float speed = 1.0;

void fragment() {
    vec2 uv = UV;
    uv.x += TIME * speed;       // Animate texture horizontally
    uv = fract(uv);             // Wrap UV coordinates to avoid disappearing
    COLOR = texture(TEXTURE, uv);
}
