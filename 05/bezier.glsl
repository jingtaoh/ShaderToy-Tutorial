float dot2(in vec2 v) { return dot(v, v); }

float sdBezier(in vec2 pos, in vec2 A, in vec2 B, in vec2 C) {
  vec2 a = B - A;
  vec2 b = A - 2.0 * B + C;
  vec2 c = a * 2.0;
  vec2 d = A - pos;
  float kk = 1.0 / dot(b, b);
  float kx = kk * dot(a, b);
  float ky = kk * (2.0 * dot(a, a) + dot(d, b)) / 3.0;
  float kz = kk * dot(d, a);
  float res = 0.0;
  float p = ky - kx * kx;
  float p3 = p * p * p;
  float q = kx * (2.0 * kx * kx - 3.0 * ky) + kz;
  float h = q * q + 4.0 * p3;
  if (h >= 0.0) {
    h = sqrt(h);
    vec2 x = (vec2(h, -h) - q) / 2.0;
    vec2 uv = sign(x) * pow(abs(x), vec2(1.0 / 3.0));
    float t = clamp(uv.x + uv.y - kx, 0.0, 1.0);
    res = dot2(d + (c + b * t) * t);
  } else {
    float z = sqrt(-p);
    float v = acos(q / (p * z * 2.0)) / 3.0;
    float m = cos(v);
    float n = sin(v) * 1.732050808;
    vec3 t = clamp(vec3(m + m, -n - m, n - m) * z - kx, 0.0, 1.0);
    res = min(dot2(d + (c + b * t.x) * t.x), dot2(d + (c + b * t.y) * t.y));
    // the third root cannot be the closest
    // res = min(res,dot2(d+(c+b*t.z)*t.z));
  }
  return sqrt(res);
}

vec3 drawScene(vec2 uv) {
  vec3 col = vec3(0);
  vec2 A = vec2(0, 0);
  vec2 B = vec2(0.2, 0);
  vec2 C = vec2(0.2, 0.2);
  float curve = sdBezier(uv, A, B, C);

  col = mix(vec3(1, 1, 1), col, step(0., curve - 0.01));

  col = mix(vec3(0, 0.5, 1), col, step(0., curve - 0.01));
  return col;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;  // <0, 1>
  uv -= 0.5;                             // <-0.5,0.5>
  uv.x *= iResolution.x / iResolution.y; // fix aspect ratio

  vec3 col = drawScene(uv);

  fragColor = vec4(col, 1.0); // Output to screen
}
