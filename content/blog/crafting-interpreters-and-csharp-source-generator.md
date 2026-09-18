+++
title = "Crafting Interpreters and C# Source Generators"
date = "2026-09-18T11:43:38+03:00"
tags = ["Csharp", "SourceGenerators"]
slug = "crafting-interpreters-and-csharp-source-generators"
description = "An introduction to C# source generators in the context of a C# Lox interpreter implementation."
+++

I re-implemented Lox, the language covered in [Crafting Interpreters](https://craftinginterpreters.com/), in .NET 10
as an exercise in recreational programming (as in [recreational mathematics](https://en.wikipedia.org/wiki/Recreational_mathematics)) but also to see how much I remember from my first stab at it. Another objective of this exercise was to see how much better I can implement things considering that I've learned some things
in the five years that passed since my first implementation (2021). And the C# language evolved in that time, creating a nicer experience for the developer.

I knew from the start that I would use [.NET Generic Host](https://learn.microsoft.com/en-us/dotnet/core/extensions/generic-host?tabs=appbuilder) and
[System.IO.Abstractions](https://github.com/TestableIO/System.IO.Abstractions) for better code organization and testing, but
I didn't expect the surprise of source generators[^1]. The book uses a different program [to generate](https://craftinginterpreters.com/representing-code.html#metaprogramming-the-trees) the boilerplate code: all the various nodes of the AST (abstract syntax tree) and the [Visitor pattern](https://craftinginterpreters.com/representing-code.html#the-visitor-pattern) contract. In my first implementation I did the same, but now I remembered I've seen somewhere that it is possible to generate code inside your project (not entirely true but the main idea is that it doesn't need to be a separate executable).

The generator is a separate project, but it is not an executable, so it integrates seamlessly into the project. No need to remember to re-generate, because everything is automatically generated on compile.

The project file shows the parts that make it a Roslyn component:

```xml {linenos=table}
<Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <TargetFramework>netstandard2.0</TargetFramework>
        <LangVersion>latest</LangVersion>

        <IsRoslynComponent>true</IsRoslynComponent>
        <EnforceExtendedAnalyzerRules>true</EnforceExtendedAnalyzerRules>
    </PropertyGroup>

    <ItemGroup>
        <PackageReference Include="Microsoft.CodeAnalysis.CSharp" 
            Version="5.6.0" PrivateAssets="All" />
    </ItemGroup>
</Project>
```

The main project references it as an analyzer, not as a normal dependency. These two attributes do
the work. Without them the project links the generator instead of running it:

```xml
<ProjectReference Include="..\cslox.generator\cslox.generator.csproj"
    OutputItemType="Analyzer" ReferenceOutputAssembly="false"/>
```

The generator targets `netstandard2.0` because the compiler loads it as an analyzer, and the
compiler runs on .NET Framework inside Visual Studio and on .NET everywhere else. Only .NET
Standard 2.0 loads in both. The target framework of the project that consumes it does not matter.

The generator is one file. The `Asts` list describes the nodes. The rest writes the source text:

```csharp {linenos=table}
[Generator]
public sealed class CsLoxAstGenerator : IIncrementalGenerator
{
    // ... definitions of private types GeneratedType and GeneratedAst

    private static readonly List<GeneratedAst> Asts =
    [
        new ("Expr",
        [
            new GeneratedType("Assign", [("Token", "Name"), ("Expr", "Value")]),
            new GeneratedType("Binary", [("Expr", "Left"), ("Token", "Operator"), ("Expr", "Right")]),
            // ...
            new GeneratedType("Unary", [("Token", "Operator"), ("Expr", "Right")])
        ]),
        new ("Stmt",
        [
            new GeneratedType("Block", [("List<Stmt>", "Statements")]),
            new GeneratedType("Class", [("Token", "Name"), ("List<Stmt.Function>", "Methods")]),
            // ...
            new GeneratedType("Return", [("Token", "Keyword"), ("Expr?", "Value")])
        ])
    ];

    // "@" so member names that camel-case into keywords (Operator -> operator) stay legal
    private static string ParameterName(string memberName)
        => "@" + char.ToLowerInvariant(memberName[0]) + memberName.Substring(1);

    public void Initialize(IncrementalGeneratorInitializationContext context)
    {
        context.RegisterPostInitializationOutput(static ctx =>
        {
            foreach (var ast in Asts)
            {
                ctx.AddSource(
                    $"CsLox{ast.BaseName}.g.cs",
                    SourceText.From(BuildAst(ast), Encoding.UTF8));
                ctx.AddSource(
                    $"{ast.VisitorName}.g.cs",
                    SourceText.From(BuildVisitor(ast), Encoding.UTF8));
            }
        });
    }

    private static string BuildAst(GeneratedAst ast)
    {
        var ssb = new StringBuilder();
        // Roslyn disables the nullable context for generated files, so nullable member
        // annotations need an explicit directive here (CS8669).
        ssb.AppendLine("#nullable enable");
        ssb.AppendLine("using cslox.Models;");
        ssb.AppendLine("namespace cslox.generator;");
        ssb.AppendLine();
        ssb.AppendLine($"public abstract class {ast.BaseName}");
        ssb.AppendLine("{");
        ssb.AppendLine($"    public abstract T Accept<T>({ast.VisitorName}<T> visitor);");
        foreach (var type in ast.Types)
        {
            // ... a nested class for each node: members, constructor, Accept
        }
        ssb.AppendLine("}");
        return ssb.ToString();
    }

    // ... BuildVisitor writes the visitor interface the same way
}
```

`RegisterPostInitializationOutput` runs once, right after initialization, and it gets no inputs. It cannot look at your code, so it only emits source that is already fixed, like the `Asts` list here. The generated code enters the compilation before anything else runs, so the rest of the project sees the classes as normal types.

This is the result. `CsLoxExpr.g.cs` holds one nested class for each node:

```csharp
#nullable enable
using cslox.Models;
namespace cslox.generator;

public abstract class Expr
{
    public abstract T Accept<T>(ICsLoxExprVisitor<T> visitor);

    // ...

    public class Binary : Expr
    {
        public Expr Left { get; }
        public Token Operator { get; }
        public Expr Right { get; }

        public Binary(Expr @left, Token @operator, Expr @right)
        {
            Left = @left;
            Operator = @operator;
            Right = @right;
        }

        public override T Accept<T>(ICsLoxExprVisitor<T> visitor)
        {
            return visitor.VisitBinary(this);
        }
    }

    // ...
}
```

`ICsLoxExprVisitor.g.cs` holds the contract that the interpreter implements:

```csharp
namespace cslox.generator;

public interface ICsLoxExprVisitor<T>
{
    T VisitAssign(Expr.Assign expr);
    T VisitBinary(Expr.Binary expr);
    // ...
    T VisitUnary(Expr.Unary expr);
}
```

The `@` on `@operator` is why the generator has a `ParameterName` helper. The member `Operator`
camel-cases into `operator`, which is a C# keyword.

To read these files on disk, build with `-p:EmitCompilerGeneratedFiles=true`. Visual Studio shows
them under **Dependencies > Analyzers**. Rider shows them under **Dependencies > net10.0 >
Source Generators**.

I think that this way of generating code is the simplest case possible. Source generators were created for more
complicated use cases. But it made a huge difference in the development experience and it was a nice, somewhat unexpected surprise.

[^1]: Roslyn calls the feature a source generator. The current API is the incremental generator. For more, see [Incremental Generators Cookbook](https://github.com/dotnet/roslyn/blob/main/docs/features/incremental-generators.cookbook.md).
