# Tech Whispers

Source of my personal blog. The site is a [Hugo](https://gohugo.io/) static site with the
[hugo-bearblog](https://github.com/janraasch/hugo-bearblog) theme.

I write about shaders, graphics, build systems, tooling, and the things that break in real systems.

## Requirements

* Hugo extended, v0.166.0 or later
* Git

Install Hugo on macOS:

```sh
brew install hugo
```

## Quick start

The theme is a Git submodule. Clone the submodule with the repository:

```sh
git clone --recurse-submodules git@github.com:phaser/tech-whispers.git
cd tech-whispers
hugo server -D
```

If you cloned without the submodule, run:

```sh
git submodule update --init --recursive
```

Open http://localhost:1313/. The `-D` flag also shows the draft pages.

## Build

```sh
hugo --minify
```

Hugo writes the site to `public/`. That directory is not in version control.

### Base URL

`hugo.toml` sets `baseURL = "https://phaser.github.io/tech-whispers/"`, the GitHub Pages URL
for this repository. Hugo uses it for the canonical URL, the Open Graph image, the favicon
link, the RSS link, and `sitemap.xml`. Page links stay relative, so a local server works
without a change.

Override the value for a different host at build time:

```sh
hugo --minify --baseURL "https://example.org/"
```

The environment variable `HUGO_BASEURL` does the same. The deploy workflow passes the URL that
GitHub Pages reports, so the workflow does not depend on the value in `hugo.toml`.

## Deploy

`.github/workflows/hugo.yml` builds the site and deploys it to GitHub Pages. The workflow runs on
each push to `main`, and on demand with **Actions → Deploy site to GitHub Pages → Run workflow**.

The Pages source must be **GitHub Actions**, not a branch. The workflow checks out the theme
submodule and pins Hugo to the version in `HUGO_VERSION`. Keep that version equal to the version
you use locally.

## Layout

| Path | Content |
| --- | --- |
| `content/_index.md` | Home page |
| `content/blog/` | Published blog posts, one Markdown file for each post |
| `drafts/` | Unpublished posts. The production build ignores this folder. |
| `content/tools.md` | The "Tools I Use" page |
| `content/books-i-love.md` | The "Books I Love" page |
| `static/` | Files that Hugo copies without change: images, `fshader-widget.js`, favicon |
| `archetypes/default.md` | Front matter template for a new page |
| `hugo.toml` | Site configuration |
| `config/development/hugo.toml` | Preview-only configuration. It mounts `drafts/` into the blog. |
| `layouts/` | Site-level templates: the `book` shortcode, and the extra CSS in `custom_head.html` |
| `.github/workflows/hugo.yml` | Build and deploy to GitHub Pages |
| `scripts/publish.sh` | Move a draft into `content/blog/` and set its date to now |
| `themes/hugo-bearblog/` | Theme submodule. Do not edit. |

## Write, preview, publish

### 1. Create the article

```sh
hugo new content blog/my-new-post.md
mv content/blog/my-new-post.md drafts/
```

`hugo new` always writes into `content/blog/`, also in the development environment. The second
command moves the file to `drafts/`, where the production build cannot see it. Use plain `mv`:
`git mv` fails on a file that Git does not track yet.

Front matter of a post:

```toml
+++
title = "My New Post"
date = "2026-01-09T16:29:09+02:00"
description = "One sentence about the post. It becomes the social preview text."
tags = ['shaders', 'webgl']
+++
```

The permalink configuration puts each post at `/<slug>/`, not at `/blog/<slug>/`.

### 2. Preview

```sh
hugo server
```

Open http://localhost:1313/tech-whispers/. The path is part of `baseURL`, so `http://localhost:1313/`
alone returns 404.

`hugo server` uses the development environment, which mounts `drafts/` into `content/blog`. A draft
gets the same URL that it gets after publication.

### 3. Publish

```sh
scripts/publish.sh my-new-post
git add -A && git commit -m "Add the post about X"
git push
```

`scripts/publish.sh` does two steps: it sets `date` in the front matter to the current time, and it
moves the file to `content/blog/`. Give the name with or without the `.md` suffix. The script uses
`git mv` when Git already tracks the file.

Do not copy the file instead of moving it. `hugo server` mounts `drafts/` into `content/blog`, so a
copy makes two pages with the same slug.

The push starts the deploy workflow. The site is live about 40 seconds later.

## Drafts

`drafts/` holds the posts that are not ready.

| Command | Sees `drafts/` |
| --- | --- |
| `hugo server` | yes |
| `hugo server -e production` | no |
| `hugo`, and the deploy workflow | no |

You do not need `draft = true` in a file that is in `drafts/`. The folder does that work.

`hugo server` writes the pages to `public/` and serves that directory. After you change the
environment, delete `public/` first, or the server answers with the pages of the previous build.

## Shader widget

Posts can show a live, editable fragment shader with the
[FShader Widget](https://github.com/phaser/fshader-widget). The bundle is in
`static/fshader-widget.js`. Use it in a post like this:

```html
<script src="/fshader-widget.js" type="module"></script>
<shader-widget canvas-width="320px" canvas-height="240px">
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec3 col = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0, 2, 4));
    fragColor = vec4(col, 1.0);
}
</shader-widget>
```

Goldmark runs with `unsafe = true`, so Hugo keeps the raw HTML in Markdown.

## Book covers

The `book` shortcode puts the cover of a book beside the text about the book. Use it like this:

```
{{< book cover="/images/books/code-petzold.jpg" alt="Code, second edition, by Charles Petzold" >}}
**[Book title](https://example.org/)**
*Author, edition, year.*

The text about the book. Plain Markdown works here: links, **bold** and lists.
{{< /book >}}
```

| Parameter | Value |
| --- | --- |
| `cover` | Site path of the cover image. Required. |
| `alt` | Alternative text for the cover. Required. |

Rules:

* Store each cover in `static/images/books/`. Use a lowercase name with dashes.
* Write `cover` as a site path that starts with a slash, `/images/books/name.jpg`. The shortcode
  refuses a relative path and a path that holds `..`, because Hugo then drops the
  `/tech-whispers/` part of `baseURL` and the cover becomes a 404.
* Start the shortcode on its own line, after an empty line. Without the empty line Goldmark puts
  the `div` of the shortcode inside a paragraph.
* The shortcode reads the size of the file and renders the cover 260px high, in a 210px column.
  It writes `width` and `height` on the `img` element, so the text does not jump when the cover
  loads. The first cover on a page loads eagerly, the rest load lazily.
* Each of these authoring mistakes is a warning in `hugo server` and an error in the production
  build: no `cover`, no `alt`, a relative path, a file that does not exist, and a file that Hugo
  cannot read as an image. The preview keeps the text of the entry, so an unfinished entry stays
  readable.

`layouts/partials/custom_head.html` holds the style of the two columns. On a narrow screen the text
moves under the cover.

## License

Content and code: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). See `LICENSE`.
The theme keeps its own license in `themes/hugo-bearblog/LICENSE`.

`static/images/share.png` is the social preview image. It contains a Mandelbulb render by
PantheraLeo1359531, published under
[CC0](https://creativecommons.org/publicdomain/zero/1.0/) on
[Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Mandelbulb_OpenCL_225MPx_20201202.png).

The files in `static/images/books/` are the covers of the books on the "Books I Love" page. Each
publisher owns its cover. The images identify the books, and the license of this repository does
not cover them.
