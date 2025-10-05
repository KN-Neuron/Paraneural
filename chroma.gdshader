shader_type spatial;
render_mode unshaded, cull_disabled, blend_mix;

uniform sampler2D screen_texture: hint_screen_texture;

// Sphere parameters (for tinting)
group_uniforms render;
uniform vec4 sphere_color: source_color = vec4(0.0, 0.0, 0.0, 0.0);

// Wave and chromatic aberration parameters
group_uniforms effects;
uniform float wave_amplitude: hint_range(0.0, 0.01) = 0.006;  
uniform float wave_frequency: hint_range(0.0, 20.0) = 3.397;  
uniform float wave_speed: hint_range(0.0, 10.0) = 0.0;  
uniform float chroma_amount: hint_range(0.0, 1.0) = 1.0; 

// Star field parameters 
group_uniforms stars;
uniform bool stars_enabled = false;      
uniform float star_field_scale: hint_range(1.0, 50.0) = 0.0;  
uniform float star_size: hint_range(0.001, 0.05) = 0.0;      
uniform float star_intensity: hint_range(0.0, 1.0) = 0.0;     
uniform float star_axis_speed: hint_range(0.0, 0.5) = 0.0;  
uniform int star_move_mode: hint_range(0, 3) = 1;  

// Helper function for random number generation.
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    // Apply wave distortion
    vec2 wave_offset = vec2(
        sin(SCREEN_UV.y * wave_frequency + TIME * wave_speed),
        sin(SCREEN_UV.x * wave_frequency + TIME * wave_speed)
    ) * wave_amplitude;
    
    vec2 distorted_uv = SCREEN_UV + wave_offset;
    
    // Chromatic aberration: offset red and blue channels.
    vec2 red_uv   = distorted_uv + wave_offset * chroma_amount;
    vec2 blue_uv  = distorted_uv - wave_offset * chroma_amount;
    vec2 green_uv = distorted_uv;
    
    float r = texture(screen_texture, red_uv).r;
    float g = texture(screen_texture, green_uv).g;
    float b = texture(screen_texture, blue_uv).b;
    vec4 scene_color = vec4(r, g, b, 1.0);
    
    // Mix the scene color with the sphere tint.
    vec3 final_color = mix(scene_color.rgb, sphere_color.rgb, sphere_color.a);

    
    ALBEDO = final_color;
    ALPHA  = 1.0;
}
