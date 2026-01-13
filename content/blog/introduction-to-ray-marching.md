+++
title = "Introduction to Ray Marching"
date = "2026-01-12T16:29:09+02:00"
description = "Just my notes on how to do ray marching"
tags = ['shadertoy', 'shaders', 'javascript', 'webgl']
custom_js = [ './fshader-widget.js' ]
+++

* [LIVE Coding "Happy Jumping"](https://www.youtube.com/live/Cfe5UQ-1L9Q?si=X4MvejtrEf3sB7Hv)
* [Kinda Technical Ray Marching](https://kindatechnical.com/computer-graphics/lesson-33-ray-marching.html)

## Introduction and perspective correction

<script src="../fshader-widget.js" type="module"></script>
<shader-widget canvas-width="320px" canvas-height="240px">

    void mainImage(out vec4 fragColor, in vec2 fragCoord) 
    {
        vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
        float f = smoothstep(0.2, 0.3, length(uv));
        vec3 col = vec3(f, f, f);
        fragColor = vec4(col, 1.0);
    }
</shader-widget>

All starts with this line which centers the coordinate system, bringing (0, 0) in the
center of the canvas but also correcting the perspective, so we see circles as circles and not as ellipses.

```
    vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
```

Here, I use the [smoothstep](https://thebookofshaders.com/glossary/?search=smoothstep) function to process `length(uv)`, which represents the distance from the center of the screen. For distances less than 0.2, the result is 0 (black); between 0.2 and 0.3, it smoothly transitions from 0 to 1; and beyond 0.3, the value is 1 (white). This effectively creates a circle in the center with a soft, anti-aliased edge.

## Ray marching

First, we define a coordinate system with `x` positive to the right, `y` positive up and `z` positive facing us. We define an origin for all rays at `vec3(0.0, 0.0, 1.0)` and a direction for the ray at the pixel position with `z = -1.5`, so going away from us.

The function `map` contains only a SDF (Signed Distance Function) for a sphere but the idea of `map` is that it will combine all the SDF function into a "merged" result. The idea is that, the map function will return negative values for the "interior" of the object and positive for the "exterior". For negative and very large values we break because it is clear we don't intersect the surface. But for the other values we iterate further by "advancing" the ray in order to get closer to the surface.

{{< figure
  src="../images/raymarching.png"
  alt="Raymarching in one image"
  caption="Raymarching in one image"
  class="ma0 w-75"
>}}

In the figure above, you can see raymarching being explained but also some light computations involving the surface normal. The raymarching process returns wheather we intersect the SDF or not and if we intersect we use the intersection ray, by computing the intersection position, to compute the surface normal and then the lighting for that pixel, taking into consideration all the lights in the scene (in this example only the sun and sky).

<shader-widget canvas-width="320px" canvas-height="240px">

    float map( in vec3 pos ) 
    {
        float d = length(pos) - 0.25;
        return d;    
    }

    vec3 calcNormal( in vec3 pos )
    {
        vec2 e = vec2(0.00001, 0);
        return normalize( vec3(map(pos + e.xyy) - map(pos - e.xyy),
                            map(pos + e.yxy) - map(pos - e.yxy),
                            map(pos + e.yyx) - map(pos - e.yyx) ) );
    }

    void mainImage(out vec4 fragColor, in vec2 fragCoord) {
        vec2 p = (2.0 * fragCoord - iResolution.xy) / iResolution.y;

        vec3 ro = vec3(0.0, 0.0, 1.0);
        vec3 rd = normalize( vec3(p, -1.5) );
        vec3 col = vec3(0.0);
        
        float t = 0.0;
        for (int i = 0; i < 100; i++)
        {
            vec3 pos = ro + t * rd;
            float h = map( pos );
            if ( h < 0.001 )
                break;
            t += h;
            // far clipping
            if ( t > 20.0 ) break;
        }
        
        if (t < 20.0 )
        {
            vec3 pos = ro + t * rd;
            vec3 nor = calcNormal(pos);
            vec3 sun_dir = normalize( vec3( 0.8, 0.4, -0.2) );
            float sun_dif = clamp ( dot (nor, sun_dir), 0.0, 1.0);
            float sky_dif = clamp ( dot (nor, vec3(0.0, 1.0, 0.0)), 0.0, 1.0);
            col  = vec3(1.0, 0.7, 0.5) * sun_dif;
            col += vec3(0.0, 0.2, 0.4) * sky_dif;
        }
        
        fragColor = vec4(col, 1.0);
    }
</shader-widget>