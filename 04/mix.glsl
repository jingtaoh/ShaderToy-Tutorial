void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy; // <0, 1>

  float interpolatedValue = mix(0., 1., uv.x);
  vec3 col = vec3(interpolatedValue);

  // Output to screen
  fragColor = vec4(col, 1.0);
}
