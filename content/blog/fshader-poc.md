+++
title = "FShader Widget"
date = "2026-01-09T16:29:09+02:00"
description = "An article about the FShader Widget project"
tags = ['shadertoy', 'shaders', 'javascript', 'webgl']
custom_js = [ './fshader-widget.js' ]
+++

I've always been a fan of [ShaderToy](https://www.shadertoy.com/) and its co-founder 
[Inigo Quilez](https://iquilezles.org/). I remember seeing one of his early presentations (sadly I can't find it anymore) about the incredible things you can do with fragment shaders alone.

But I've always had one gripe: to create or view shaders, you have to go to ShaderToy's website. Since ShaderToy uses browser APIs that are available everywhere, shaders should be shareable and embeddable anywhere. The setup code is the same for every shader, so it can be abstracted away into a reusable widget.

ShaderToy doesn't enable embedding, and that's fine; it's not their goal. But I always thought it shouldn't be too hard to create a widget that lets you embed shader code and render it in real time, right on the page.

<script src="../fshader-widget.js" type="module"></script>
<shader-widget width="320" height="320">
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec3 col = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0, 2, 4));
    fragColor = vec4(col, 1.0);
}
</shader-widget>