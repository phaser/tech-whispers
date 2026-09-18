+++
title = "Crafting Interpreters and C# Source Generators"
date = "2026-09-17T16:40:46+03:00"
tags = ["csharp", "source generators"]
slug = "crafting-interpreters-and-csharp-source-generators"
description = "An introduction to C# source generators in the context of a C# Lox interpreter implementation."
+++

## TODO List
- [ ] Introduce the usefulness of the concept starting from the code generation needs of *Crafting Interpreters*
- [ ] Present the implementation
- [ ] Improvements after the fact

I [re-implemented Lox](https://github.com/phaser/cslox), which is the language covered in [Crafting Interpreters](https://craftinginterpreters.com/), in .NET 10
as an exercise in recreational programming but also to see how much I remember from my first stab at it. Another objective of this exercise was to see how much better I can implement things considering that I've learned some things
in the five years that passed since my first implementation (2021). And the C# language evolved in that time, creating a nicer experience for the developer.

I knew from the start that I would use [.NET Generic Host](https://learn.microsoft.com/en-us/dotnet/core/extensions/generic-host?tabs=appbuilder) and
[System.IO.Abstractions](https://github.com/TestableIO/System.IO.Abstractions) for better code organization and testing, but
I didn't expect the surprise of source generators[^1]. The book uses a different program [to generate](https://craftinginterpreters.com/representing-code.html#metaprogramming-the-trees) the boilerplate code: all the various nodes of the AST (abstract syntax tree) and the [Visitor pattern](https://craftinginterpreters.com/representing-code.html#the-visitor-pattern) contract. In my first implementation I did the same, but now I remembered I've seen somewhere that it is possible to generate code inside your project (not entirely true but the main idea is that it doesn't need to be a separate executable).

[^1]: Roslyn calls the feature a source generator. The current API is the incremental generator. For more, see [Incremental Generators Cookbook](https://github.com/dotnet/roslyn/blob/main/docs/features/incremental-generators.cookbook.md).
