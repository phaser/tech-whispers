+++
title = "Article Ideas"
date = "2026-09-17"
draft = true
description = "Working list of article ideas with the source of each one."
+++

Working notes, not an article. `draft = true` keeps this file out of the preview server too.

**Provenance.** *Source* means a real artifact: a commit, a pull request, a README or a notes
page. *Inferred* means the idea is an extrapolation and has no single artifact behind it.

**This repository is public.** Work-derived items cite the topic and the month only. Do not add
ticket ids, service names, build ids or cost figures to this file. Generalize each of those items
before you write it.

## Proxy and HTTP — from `shmoxy`

**1. Why I wrote my own intercepting proxy**
Angle: what the existing proxies did not give me, and the cost of owning one.
Source: `shmoxy/README.md` ("A .NET proxy server that terminates TLS connections... supports
dynamic certificate generation"). 216 commits between March and September 2026, the highest of
any personal repository. This is my first project done almost 100% with AI. The interesting parts here 
is that I used multiple models and I evolved the setup along the way, until at the end I just added issues
in github and asked the LLM to execute them one by one. A true case of [automatic programming](https://antirez.com/news/159).

## Interpreters — from `cslox`

**7. Writing Lox in C#**
Angle: what *Crafting Interpreters* leaves to the reader when the host language is not Java.
Source: repository description, "Implementation of Lox interpreter in C#". 57 commits since March.

## Durable workflows and modules — from `dbos-transact-csharp` and `orian`

**11. Porting a Java library to C# without writing Java**
Angle: where an idiomatic port must break from the reference implementation.
Source: `dbos-transact-csharp/README.md`, "A C#/.NET port of dbos-transact-java... the API closely
mirrors the Java reference implementation". 52 commits since March.

## How you run Claude Code

**28. A CLAUDE.md that changes behaviour**
Angle: which rules survive a long session and which quietly stop being applied.
Source: `~/.claude/CLAUDE.md`. The rules for session goals, always linking URLs and Simplified
Technical English, each with a note about why the earlier version failed.

**29. An LLM-maintained wiki**
Angle: ingest, query and lint over a vault of more than 150 pages, with links as the only index.
Source: the vault at `~/projects/claude_wiki`. Concepts, entities, summaries, syntheses and a
journal, plus a master index and an append-only log.

**30. Work trackers an agent can read**
Angle: pull request state in Markdown, so the next session starts informed.
Source: the `work/` tracker in the same vault, one file per pull request, grouped by epic in an
index.

**32. A local model behind the agent CLI**
Angle: point the agent at a local server with one environment variable. What it is good for, and
what it is not.
Source: the `claude-local` alias in the machine configuration, which sets the base URL to
`http://localhost:1234` for LM Studio.

**33. Tracing agent runs**
Angle: what a trace of an agent session shows that a transcript does not.
Source: the OpenTelemetry exporter variables in the machine configuration, pointing at a local
Langfuse instance.

**34. When the connector fails, use the CLI**
Angle: fallbacks that keep a session moving when a connector is down.
Source: the "MCP outage fallback" section of `~/.claude/CLAUDE.md`, which lists a local equivalent
for each connector.

## Security and bounties — from `cyber-bounties`

**49. Automating multi-factor authentication in test environments**
Angle: time-based one-time passwords done correctly, without weakening the account.
Source: work notes on TOTP, July 2026.

## Graphics

**50. Ray marching, part two**
Angle: normals, soft shadows and ambient occlusion, each with a live widget.
Source: `drafts/introduction-to-ray-marching.md`. The draft stops after the second widget and the
lighting paragraph. Part two is the continuation you already started.

## Not in the 50

* Syncing shell history between two machines. Source: the `hister-sync` repository, September 2026.
  repository.
