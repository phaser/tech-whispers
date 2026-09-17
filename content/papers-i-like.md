+++
title = "Papers I Like"
date = "2026-09-17T08:58:06+03:00"
description = "Papers I read and liked over the years. This is an evolving article!"
tags = ["papers", "low level", "distributed systems"]
+++

*Updated: 17 Sep, 2026. This page is a work in progress.*

Good papers are those you always come back to without needing a reminder they're good. But there is value in keeping a list because
re-reading the same paper gives you a bit more insight and a new appreciation for the concept. I'll keep this article up to date with
the papers I read and love.

* [What every programmer should know about memory](https://people.freebsd.org/~lstewart/articles/cpumemory.pdf)
    * Ulrich Drepper, 2007
    * This is the first paper that made me think seriously about architecture and how understanding some low level concepts can actually give me superpowers to optimize at a higher level.

* [Smashing the stack for fun and profit](https://inst.eecs.berkeley.edu/~cs161/archive/fa08/papers/stack_smashing.pdf)
    * Aleph One, 1996
    * It took me longer than it needed (in retrospect) to really understand the stack and the heap as managed by C/C++ programs. When I read this for the first time it was like a magician explaining his tricks but instead of making the trick unimpressive, it made it more magical! These days it is more complicated to do exploits like these because of the new security fences ([ASLR](https://en.wikipedia.org/wiki/Address_space_layout_randomization), [stack canaries](https://dev.to/bytehackr/top-5-compiler-flags-to-prevent-stack-based-attacks-32a0) etc) but the paper is still iconic, because it was the first paper that explained in simple terms how to exploit binaries.

* [Time, Clocks, and the Ordering of Events in a Distributed System](https://lamport.azurewebsites.net/pubs/time-clocks.pdf)
    * Leslie Lamport, 1978

