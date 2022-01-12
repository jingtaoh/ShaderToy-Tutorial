vec3 getBackgroundColor(vec2 uv) {
  uv += 0.5; // remap uv from <-0.5,0.5> to <0,1>
  vec3 gradientStartColor = vec3(1., 1., 0.);
  vec3 gradientEndColor = vec3(0., 1., 1.);
  return mix(gradientStartColor, gradientEndColor,
             uv.y); // gradient goes from bottom to top
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;  // <0, 1>
  uv -= 0.5;                             // <-0.5,0.5>
  uv.x *= iResolution.x / iResolution.y; // fix aspect ratio

  vec3 col = getBackgroundColor(uv);

  // Output to screen
  fragColor = vec4(col, 1.0);
}
