shader_type canvas_item;


uniform vec2 resolution;
uniform vec2 mouse_pos;
uniform float speed_multiplier = 1.0;
uniform bool enable_background = true;
uniform vec4 background_color = vec4(0.0, 0.0, 0.0, 1.0); 


float No(float x, vec2 T){
	return fract(9667.5 * sin(7983.75 * (x + T.x) + 297. + T.y));
}
vec4 Rancol(vec2 x, vec2 T){
	return vec4(No(x.x + x.y, T), No(x.x*x.x + x.y, T), No(x.x*x.x + x.y*x.y, T), 1.0);
}
vec4 grid(vec2 uv, float t, vec2 T){
	vec4 C1 = vec4(0.0);
	vec4 C2 = vec4(0.0);
	uv *= 20.0;
	vec2 id = vec2(floor(uv.x), floor(uv.y));
	uv.y += (5.0 * No(id.x * id.x, T) + 1.0) * t * 0.04;
	uv.y += No(id.x, T);
	id = vec2(floor(uv.x), floor(uv.y));
	uv = fract(uv) - 0.5;
	float d = length(uv);
	float t_local = t * (1.0 * No(id.x + id.y, T));
	float r = 0.1 * sin(t_local + sin(t_local) * 0.5) + 0.3;
	float r1 = 0.07 * sin(2.0 * t_local + sin(2.0 * t_local) * 0.5) + 0.1 * No(id.x + id.y, T);
	if (d < r && d > r - 0.1) {
		C2 = 0.5 * Rancol(id + vec2(1.0), T) + vec4(0.5);
		C2 *= smoothstep(r - 0.12, r, d);
		C2 *= 1.0 - smoothstep(r - 0.05, r + 0.12, d);
	}
	if (d < r1) {
		C2 = 0.5 * Rancol(id + vec2(1.0), T) + vec4(0.5);
	}
	return C2 + C1;
}


void fragment() {
	vec2 uv = FRAGCOORD.xy / resolution.xy;
	uv.y *= resolution.y / resolution.x;
	float t = TIME * speed_multiplier;
    vec2 T = mouse_pos / resolution;
	vec4 final_color = grid(uv, t, T);

    if (enable_background) {
        final_color += background_color;
    }

    COLOR = final_color;
}
