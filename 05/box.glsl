vec3 getBackgroundColor(vec2 uv) {
  uv = uv * 0.5 + 0.5; // remap uv from <-0.5,0.5> to <0.25,0.75>
  vec3 gradientStartColor = vec3(1., 1., 0.);
  vec3 gradientEndColor = vec3(0., 1., 1.);
  return mix(gradientStartColor, gradientEndColor,
             uv.y); // gradient goes from bottom to top
}

float sdHeart(vec2 uv, float size, vec2 offset) {
  float x = uv.x - offset.x;
  float y = uv.y - offset.y;
  float group = dot(x, x) + dot(y, y) - size;
  float d = group * dot(group, group) - dot(x, x) * dot(y, y) * y;

  return d;
}

vec3 drawScene(vec2 uv) {
  vec3 col = getBackgroundColor(uv);

  float heart = sdHeart(uv, 0.04, vec2(0));

  col = mix(vec3(1, 0, 0), col, step(0., heart));
  return col;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;  // <0, 1>
  uv -= 0.5;                             // <-0.5,0.5>
  uv.x *= iResolution.x / iResolution.y; // fix aspect ratio

  vec3 col = drawScene(uv);

  fragColor = vec4(col, 1.0); // Output to screen
}
