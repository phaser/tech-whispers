+++
date = '2026-11-08T18:11:59+02:00'
title = 'Linux From Scratch With Nix'
description = 'A field report on learning Nix'
tags = [ 'nix', 'llms', 'linux-from-scratch', 'linux' ]
images = [ 'images/linux-from-scratch-with-nix-cover.png' ]
+++

There are some changes that have come with the LLM age: one is that configuring
complicated stuff is no longer a blocker, and the other is that learning
anything is now possible with instant access to information and a private tutor.
The curious thing is that these two possibilities shouldn't exist at the same
time. Why would anyone need to learn anything if they can just ask their LLM to
do anything for them? My answer to this question is that I want to at least be
able to tell whether the LLM is doing a good job, and I'm not talking about
technical details, such as the code it writes, but about the higher-level, more
abstract parts. Did it misunderstand something and, as a consequence, make a bad
architectural choice? Did I misunderstand something and ask for the wrong thing?
And so on.

At the beginning of this year I found myself managing two machines (both MacBook
Pro M4s), one from work and one personal. I wanted to have the same environment
on both, not because I used my personal laptop for work, but because I wanted to
be able to try out ideas on either machine, so I wanted the same tools and
programs on both, just in case.

Along the way things went well enough, but I hit some issues that were really
inscrutable to me. They appeared in places I didn't expect. With the little I
was doing, I shouldn't have hit them at all, or not in this bad manner that
requires some back-and-forth with the LLM to fix it.

Here is the kind of thing that used to puzzle me. Nix can manage Homebrew
packages as part of the same configuration. In some cases I installed a program
through Homebrew, hit an error that had nothing to do with Nix, and went back
and forth with the LLM to fix it. Nix still reported that it had installed the
package—it had even downloaded it—but because Homebrew was part of the
configuration, the system never switched to the new derivation. At some point I
tried to ignore the Homebrew error and run the new program, convinced it was
installed. It wasn't, and the shell rightly said it couldn't find it. It is
obvious now: the switch is all or nothing.

On top of all this I really liked the promises of [Nix](https://nixos.org/), so I
decided to use this opportunity to test the idea of the LLM as a tutor and learn
Nix. So I asked for a plan in the style of
["Learn Python the Hard Way"](https://learnpythonthehardway.org/) and got to
work. It went well for a while, but once I'd covered enough concepts, I wanted
something meatier, some project I could challenge myself with.

This is when the idea of [Linux From Scratch](https://www.linuxfromscratch.org/)
came to mind. I worked through the book many years ago, and a goal I never
finished was to build a small distro with an automated build system and package
manager. One thing I wanted back then was to save my build scripts and have an
easy way to experiment with new program versions. So it clicked instantly:
this is an ideal project to learn Nix further, and to produce a set of
reusable instructions that build the same thing over and over, instructions I
can evolve and experiment with when curiosity pushes me.

So I asked the LLM for documentation on how to achieve what I wanted in the same
style as before, and got to work. The documentation became a book organized with
[mdBook](https://rust-lang.github.io/mdBook/). During this I spotted a lot of
mistakes and things that I could add to it. I wanted to build everything but I
was a Nix novice, so I needed my hand held. Initially the book didn't really
do that. It told me what I needed to achieve in broad strokes. So I added the
full Nix file where it was necessary and started each step with new Nix
concepts. The reader could study the concepts first, or—like me—just start
building, then ask questions and explore how things worked. Also not all
instructions worked from the first try. So I went back and forth until
everything built just fine. The book evolved as I neared the finish line: a
Linux toolchain built from source, a Nix stdenv with no host binaries, and a
minimal bootable rootfs. At the end I took a look at the
[book](https://phaser.github.io/linux-from-scratch-with-nix/) and I thought it
was quite good.

When I turned my attention to my
[nix-darwin](https://github.com/nix-darwin/nix-darwin) configuration I
immediately started spotting things I didn't quite like. First, a small thing:
in some spots `with pkgs` would have read better. Then, my overreliance on
[Homebrew](https://brew.sh/). I realized this was because a few programs
installed via Nix didn't work as I needed them to, and instead of finding the
root cause I gave up and used what I knew. So I moved most of them over to Nix.

The experiment taught me two things:

  * An LLM can be a great tutor.
  * We should keep learning even when we rely on LLMs. Otherwise the act of
    creating something is janky: if we stumble through it ourselves, at least we
    learn from the experience; if we hand it over, we learn nothing and have no
    way to improve it.

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
