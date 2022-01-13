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

float sdSquare(vec2 uv, float size, vec2 offset) {
  float x = uv.x - offset.x;
  float y = uv.y - offset.y;

  return max(abs(x), abs(y)) - size;
}

vec3 drawScene(vec2 uv) {
  vec3 col = getBackgroundColor(uv);
  float d1 = sdCircle(uv, 0.1, vec2(0., 0.));
  float d2 = sdSquare(uv, 0.1, vec2(0.1, 0));

  float res;         // result
  res = max(min(d1, d2), -max(d1, d2)); // xor

  res = step(0., res); // Same as res > 0. ? 1. : 0.;

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
