void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  // Normalized pixel coordinates (from 0 to 1)
  vec2 uv = fragCoord / iResolution.xy;

  vec3 col = vec3(uv, 0); // This is the same as vec3(uv.x, uv.y, 0)

  // Output to screen
  fragColor = vec4(col, 1.0);
}