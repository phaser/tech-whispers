+++
date = "2026-11-08T20:56:59+02:00"
title = 'Linux From Scratch With Nix'
description = 'Using an LLM as a tutor to learn Nix, build Linux From Scratch with it, and clean up a real nix-darwin config.'
tags = [ 'nix', 'llms', 'linux-from-scratch', 'linux' ]
images = [ 'images/linux-from-scratch-with-nix-cover.png' ]
+++

There are some changes that have come with the LLM age: one is that configuring
complicated stuff is no longer a blocker, and the other is that learning
anything is now possible with instant access to information and a private tutor.
At first glance the two seem to cancel each other out: why learn anything if the
LLM can just do it for you?

My answer is that I want to be able to tell whether the LLM is doing a good
job, not just at the level of code details, but at the higher-level, more
abstract parts. Did it misunderstand something and make a bad architectural
choice? Did I misunderstand something and ask for the wrong thing? That kind of
judgment still requires understanding.

At the beginning of this year I found myself managing two machines (both MacBook
Pro M4s), one from work and one personal. I wanted to have the same environment
on both, not because I used my personal laptop for work, but because I wanted to
be able to try out ideas on either machine, so I wanted the same tools and
programs on both, just in case.

Along the way things went well enough, but I hit some issues that were really
inscrutable to me. They showed up in places I didn't expect, and for how little
I was doing, I shouldn't have hit them at all, let alone ones that took several
rounds with the LLM to fix.

Here is the kind of thing that used to puzzle me. On macOS,
[nix-darwin](https://github.com/nix-darwin/nix-darwin) can manage Homebrew
packages declaratively as part of the same configuration. In my case, a Homebrew
install step failed for reasons unrelated to Nix, and I went back and forth with
the LLM trying to fix it. Because that Homebrew step was part of the same
activation, the whole switch failed, so the system never moved to the new
generation. Nix had already built or fetched what it needed, but the new program
never ended up on my `PATH`. At some point I tried to ignore the Homebrew error
and run the new program, convinced it was installed. It wasn't, and the shell
rightly said it couldn't find it. It is obvious now: activation is effectively
all or nothing.

On top of all this I really liked the promises of [Nix](https://nixos.org/), so I
decided to use this opportunity to test the idea of the LLM as a tutor and learn
Nix. I asked for a plan in the style of
["Learn Python the Hard Way"](https://learnpythonthehardway.org/) and got to
work. It went well for a while, but once I'd covered enough concepts, I wanted
something meatier, some project I could challenge myself with.

This is when the idea of [Linux From Scratch](https://www.linuxfromscratch.org/)
came to mind. I worked through the book many years ago, and a goal I never
finished was to build a small distro with an automated build system and package
manager. One thing I wanted back then was to save my build scripts and have an
easy way to experiment with new program versions. So it clicked instantly:
this was an ideal project to learn Nix further, on my Mac, inside an
`aarch64-linux` environment (the book covers a Tart VM, a Docker container, or a
native aarch64 Linux machine), and to produce a set of reusable instructions
that build the same thing over and over, instructions I can evolve and
experiment with when curiosity pushes me.

Next, I had the LLM generate documentation for that project in the same style as
before and got to work. The documentation became a book organized with
[mdBook](https://rust-lang.github.io/mdBook/). Along the way I spotted a lot of
mistakes and found places where I could add detail. I wanted to build everything,
but I was a Nix novice, so I needed more hand-holding. Initially the book didn't
really do that. It told me what to achieve in broad strokes. So I added the full
Nix file where it was necessary and started each step with the new Nix concepts
involved. The reader could study the concepts first, or, like me, just start
building, then ask questions and explore how things worked. Not all of the
instructions worked on the first try, so I went back and forth until everything
built. At the end I took a look at the
[book](https://phaser.github.io/linux-from-scratch-with-nix/) and thought it was
quite good. Using only Nix, it takes you through:

  * a from-scratch aarch64 toolchain, LFS-style
  * a `stdenv` with no host binaries, and packages built with it
  * a kernel, BusyBox, and a minimal system that boots in QEMU from an ext4 root
    image

Each step starts with the Nix concepts it uses, gives the full Nix files, and
has checks with expected output. To make sure it holds up, I redid the first
eleven steps from the book text alone, in a fresh container with an empty Nix
store, and got the same derivations, all 51 of them.

When I turned my attention to my
[nix-darwin](https://github.com/nix-darwin/nix-darwin) configuration, I
immediately started spotting things I didn't quite like. There was a small style
nit (in some spots `with pkgs` would have read better), but the bigger issue was
my overreliance on [Homebrew](https://brew.sh/). I realized this had happened
because a few programs installed via Nix didn't work the way I needed them to,
and instead of finding the root cause I had given up and used what I knew. This
time I moved most of them over to Nix.

The experiment taught me two things:

  * An LLM can be a great tutor.
  * We should keep learning even when we rely on LLMs. If we stumble through
    something ourselves, at least we learn from it. If we hand it all over, we
    learn nothing and have no way to improve the result.

The config cleanup is the clearest example of what I think is the best
strategy: start doing something with an LLM. If the experience is not
smooth, there is friction somewhere. The fastest way to fix it is to
ask the LLM to teach you what is being done, until you understand it well
enough to decide who's at fault.

And who knows? You might get a book out of it!

{{< figure
  src="../images/linux-from-scratch-with-nix-cover.png"
  link="https://phaser.github.io/linux-from-scratch-with-nix/"
  alt="Cover of Linux From Scratch with Nix by Cristian Bidea and LLMs"
  caption="Linux From Scratch with Nix"
  class="cover"
>}}
