shader_type canvas_item;

// made by b en at https://godotshaders.com/shader/accurate-fnaf-panorama/

uniform int zoom = 75;
uniform bool smoothed = true;

//Disable this line for Godot 3.x//
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest;

varying vec2 screen_center;

void vertex() {
	screen_center = (CANVAS_MATRIX * MODEL_MATRIX[3]).xy;
}

void fragment() {
    lowp float fB;
    lowp float fC;

    //Change this if you want to make the stairstepping more/less intense//
    const float steps = 230.0;

    vec2 posTex;
    vec2 uv = SCREEN_UV;
	vec2 centerUV = screen_center * SCREEN_PIXEL_SIZE;
	vec2 aspect_ratio = vec2(SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x, 1.0);
	vec2 adjusted_uv = (uv - centerUV) * aspect_ratio + centerUV;


    fB = 1.0 - (float(zoom) * .0015);
    fC = max(.02, 1.0 + (fB - 1.0) * 4.0 * pow((UV.x - 0.5), 2.0));
    //if (!smoothed){
    //fC = float(int(fC * steps)) / steps;
    

    posTex = (uv * vec2(1.0, fC) + vec2(0.0, (1.0 - fC) * 0.5));

    //if(noWrap == false || (posTex.y >= 0.0 && posTex.y <= 1.0)){
    COLOR.rgb = texture(SCREEN_TEXTURE, posTex).rgb;
    //}

  
}