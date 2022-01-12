void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy; // <0,1>

  vec3 col = vec3(0); // start with black

  col = vec3(
      step(0.5, uv),
      0); // perform step function across the x-component and y-component of uv

  // Output to screen
  fragColor = vec4(col, 1.0);
}