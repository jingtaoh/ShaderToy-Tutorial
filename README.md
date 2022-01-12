# ShaderToy-Tutorial 🖼️
Tutorial codes from [Shadertoy series](https://inspirnathan.com/posts/47-shadertoy-tutorial-part-1/) by [Nathan Vaughn](https://twitter.com/inspirnathan).

## 01 Intro
 The `uv` variable represents the normalized canvas coordinates between zero and one on both the x-axis and the y-axis. The bottom-left corner of the canvas has the coordinate (0, 0). The top-right corner of the canvas has the coordinate (1, 1).
 ```glsl
   vec2 uv = fragCoord/iResolution.xy; // <0,1>
 ```
[![UV](01/uv.png)](01/uv.glsl)

## 02 Circles and Animation
The `step` function accepts two inputs: the edge of the step function, and a value used to generate the step function. If the second parameter in the function argument is greater than the first, then return a value of one. Otherwise, return a value of zero.
```glsl
  col = vec3(step(0.5, uv), 0); // perform step function across the x-component and y-component of uv
```
[![step](02/step.png)](02/step.glsl)

A function called `sdfCircle` that returns the color, white, for each pixel at an XY-coordinate such that the equation is greater than zero and the color, blue, otherwise.
```glsl
vec3 sdfCircle(vec2 uv, float r) {
    float x = uv.x;
    float y = uv.y;
    
    float d = length(vec2(x, y)) - r;
    
    return d > 0. ? vec3(1.) : vec3(0., 0., 1.);
}
```
[![circle](02/circle.png)](02/circle.glsl)

Use the global `iTime` variable to change colors over time.
```glsl
  return d > 0. ? vec3(0.) : 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0,2,4));
```
[![colorful](02/colorful.gif)](02/colorful.glsl)

Adjust the `sdfCircle` function to allow `offsets` and then move the center of the circle using `iTime`.
```glsl
vec3 sdfCircle(vec2 uv, float r, vec2 offset) {
  float x = uv.x - offset.x;
  float y = uv.y - offset.y;
  // ...
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  // ...
  
  vec2 offset = vec2(sin(iTime*2.)*0.2, cos(iTime*2.)*0.2); // move the circle clockwise
  
  vec3 col = sdfCircle(uv, .2, offset);

  //...
}
```
[![rotate](02/rotate.gif)](02/rotate.glsl)

## 03 Squares and Rotation
Drawing a square is very similar to drawing a circle except we will use the following equation: 
```glsl
vec3 sdfSquare(vec2 uv, float size, vec2 offset) {
  float x = uv.x - offset.x;
  float y = uv.y - offset.y;
  float d = max(abs(x), abs(y)) - size;
  
  return d > 0. ? vec3(1.) : vec3(1., 0., 0.);
}
```
[![square](03/square.png)](03/square.glsl)

A `rotate` function that accepts UV coordinates and an angle by which to rotate the square.
```glsl
vec2 rotate(vec2 uv, float th) {
  return mat2(cos(th), sin(th), -sin(th), cos(th)) * uv;
}
```
[![rotate](03/rotate.gif)](3/rotate.glsl)
