shader_type canvas_item;

// made by b en at https://godotshaders.com/shader/accurate-fnaf-panorama/

uniform int zoom = 75;
uniform bool smoothed = true;


uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float wave_count : hint_range(1.0, 20.0, 1.0) = 20.0;
uniform float speed : hint_range(0.0, 10.0, 0.1) = 3.0;
uniform float height : hint_range(0.0, 10.0, 0.001) = 0.003;
uniform vec4 colour : source_color;

//Disable this line for Godot 3.x//
//uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest;

varying vec2 screen_center;

void vertex() {
	screen_center = (CANVAS_MATRIX * MODEL_MATRIX[3]).xy;
}

void fragment() {
	
	
	vec2 cPos = -1.0 + vec2(2.0 * UV.x , UV.y) / (1.0 / TEXTURE_PIXEL_SIZE);
	float cLength = length(cPos);
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy + (cPos/cLength) * cos(cLength * wave_count - TIME * speed) * height;
    vec3 col = texture(SCREEN_TEXTURE,uv).xyz;
	
    lowp float fB;
    lowp float fC;

    //Change this if you want to make the stairstepping more/less intense//
    const float steps = 230.0;

    vec2 posTex;
    //vec2 uv = SCREEN_UV;
	vec2 centerUV = screen_center * SCREEN_PIXEL_SIZE;
	vec2 aspect_ratio = vec2(SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x, 1.0);
	vec2 adjusted_uv = (uv - centerUV) * aspect_ratio + centerUV;


    fB = 1.0 - (float(zoom) * .0015);
    fC = max(.02, 1.0 + (fB - 1.0) * 4.0 * pow((UV.x - 0.5), 2.0));
    //if (!smoothed){
    //fC = float(int(fC * steps)) / steps;
    

    


	COLOR = vec4(col,1.0);
	COLOR = mix(colour, COLOR, float(int(UV.y * 160.0) % 2));
    //if(noWrap == false || (posTex.y >= 0.0 && posTex.y <= 1.0)){
    COLOR.rgb = texture(SCREEN_TEXTURE, posTex).rgb;
    //}

  
}