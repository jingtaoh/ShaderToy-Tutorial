vec3 getBackgroundColor(vec2 uv) {
  uv = uv * 0.5 + 0.5; // remap uv from <-0.5,0.5> to <0.25,0.75>
  vec3 gradientStartColor = vec3(1., 1., 0.);
  vec3 gradientEndColor = vec3(0., 1., 1.);
  return mix(gradientStartColor, gradientEndColor,
             uv.y); // gradient goes from bottom to top
}

float sdSegment(in vec2 p, in vec2 a, in vec2 b) {
  vec2 pa = p - a, ba = b - a;
  float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
  return length(pa - ba * h);
}

vec3 drawScene(vec2 uv) {
  vec3 col = getBackgroundColor(uv);

  float segment = sdSegment(uv, vec2(0, 0), vec2(0, 0.2));

  float thickness = 0.02;
  col = mix(
      vec3(1, 0.5, 0), col,
      step(0., segment - thickness)); // Subtract 0.02 from the returned
                                      // "signed distance" value of the segment

  return col;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;  // <0, 1>
  uv -= 0.5;                             // <-0.5,0.5>
  uv.x *= iResolution.x / iResolution.y; // fix aspect ratio

  vec3 col = drawScene(uv);

  fragColor = vec4(col, 1.0); // Output to screen
}
