shader_type canvas_item;

uniform float radius      : hint_range(0.0, 0.5) = 0.35;
uniform float divide      : hint_range(0.0, 1.0) = 0.0;
uniform float blur        : hint_range(0.0, 1.0) = 0.15;
uniform vec2  center      = vec2(0.5, 0.5); // screen center

void fragment() {
    // Use SCREEN_UV for camera/screen-locked mask
    vec2 uv = SCREEN_UV;

    float dist = distance(uv, center);

    // Normalize distance inside the fade band
    float px = (radius - dist) / radius;

    float alpha = smoothstep(divide, divide + blur, px);

    // True mask
    if (alpha <= 0.001) {
        discard;
    }

    COLOR = vec4(COLOR.rgb, COLOR.a * alpha);
}
