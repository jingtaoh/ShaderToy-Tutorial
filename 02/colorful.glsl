vec3 sdfCircle(vec2 uv, float r) {
  float x = uv.x;
  float y = uv.y;

  float d = length(vec2(x, y)) - r;

  return d > 0. ? vec3(0.) : 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0, 2, 4));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy; // <0,1>
  uv -= 0.5;
  uv.x *= iResolution.x / iResolution.y; // fix aspect ratio

  vec3 col = sdfCircle(uv, .2);

  // Output to screen
  fragColor = vec4(col, 1.0);
}