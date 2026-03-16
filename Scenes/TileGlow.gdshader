shader_type canvas_item;

uniform float strength = 1.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    float pulse = sin(TIME * 2.0) * 0.5 - 0.4;
    COLOR = tex;
    COLOR.rgb += tex.rgb * (strength/2.0) * pulse;
}