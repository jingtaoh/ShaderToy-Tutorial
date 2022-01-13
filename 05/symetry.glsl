vec3 getBackgroundColor(vec2 uv) {
  uv = uv * 0.5 + 0.5; // remap uv from <-0.5,0.5> to <0.25,0.75>
  vec3 gradientStartColor = vec3(1., 1., 0.);
  vec3 gradientEndColor = vec3(0., 1., 1.);
  return mix(gradientStartColor, gradientEndColor,
             uv.y); // gradient goes from bottom to top
}

float sdCircle(vec2 uv, float r, vec2 offset) {
  float x = uv.x - offset.x;
  float y = uv.y - offset.y;

  return length(vec2(x, y)) - r;
}

float opSymX(vec2 p, float r) {
  p.x = abs(p.x);
  return sdCircle(p, r, vec2(0.2, 0));
}

float opSymY(vec2 p, float r) {
  p.y = abs(p.y);
  return sdCircle(p, r, vec2(0, 0.2));
}

float opSymXY(vec2 p, float r) {
  p = abs(p);
  return sdCircle(p, r, vec2(0.2));
}

vec3 drawScene(vec2 uv) {
  vec3 col = getBackgroundColor(uv);

  float res; // result
  res = opSymXY(uv, 0.1);

  res = step(0., res);
  col = mix(vec3(0, 0.5, 1), col, res);
  return col;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;  // <0, 1>
  uv -= 0.5;                             // <-0.5,0.5>
  uv.x *= iResolution.x / iResolution.y; // fix aspect ratio

  vec3 col = drawScene(uv);

  fragColor = vec4(col, 1.0); // Output to screen
}
