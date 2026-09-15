+++
title = "FShader Widget"
date = "2026-01-09T16:29:09+02:00"
description = "A web component that renders and edits ShaderToy-style fragment shaders directly in the page."
tags = ['shadertoy', 'shaders', 'javascript', 'webgl']
+++

<img src="/images/github-mark.png" width="32" height="32" alt="GitHub" style="background: white; clip-path: circle(); vertical-align: middle;" /> [FShader Widget Github Repository](https://github.com/phaser/fshader-widget)

I've always been a fan of [ShaderToy](https://www.shadertoy.com/) and its co-founder
[Inigo Quilez](https://iquilezles.org/). I remember seeing one of his early presentations (sadly I can't find it anymore) about the incredible things you can do with fragment shaders alone.

I do not write shaders often. Every time I get back to "toy" shaders, I tell myself to write some notes down. But notes on their own are not enough: I want to see my examples running, and I want to edit them and play with the code.

I know you can embed ShaderToy via `iframe`, but I wanted something more flexible and that I completely own. So I hacked together a widget that shows the shader source in an editor next to the running shader.

Below you can see a simple shader example. Type in the box. The canvas updates as you type.

<script src="/fshader-widget.js" type="module"></script>
<shader-widget canvas-width="320px" canvas-height="240px">
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec3 col = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0, 2, 4));
    fragColor = vec4(col, 1.0);
}
</shader-widget>

## Usage

Load the script once per page. Then put the shader source inside a `<shader-widget>` element.

```html
<script src="/fshader-widget.js" type="module"></script>
<shader-widget canvas-width="320px" canvas-height="240px">
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
</shader-widget>
```

A complete page is in [dist/index.html](https://github.com/phaser/fshader-widget/blob/main/dist/index.html).

## Limits

The widget is a work in progress:

* Only two ShaderToy uniforms are passed in: `iTime` and `iResolution`. A shader that uses `iMouse` or `iChannel0` does not compile.
* The animation runs non-stop. There is no pause control.
* The widget needs WebGL and JavaScript. Without them the canvas stays empty and you see the source only.
