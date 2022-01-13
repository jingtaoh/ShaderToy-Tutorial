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

float opRep(vec2 p, float r, vec2 c) {
  vec2 q = mod(p + 0.5 * c, c) - 0.5 * c;
  return sdCircle(q, r, vec2(0));
}

float opRepLim(vec2 p, float r, float c, vec2 l) {
  vec2 q = p - c * clamp(round(p / c), -l, l);
  return sdCircle(q, r, vec2(0));
}

vec3 drawScene(vec2 uv) {
  vec3 col = getBackgroundColor(uv);

  float res;         // result
  // infinite number 
  // res = opRep(uv, 0.05, vec2(0.2, 0.2));
  
  // 2 extra circle along x and y axis
  res = opRepLim(uv, 0.05, 0.15, vec2(2, 2));

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
