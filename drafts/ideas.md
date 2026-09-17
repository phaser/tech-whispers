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
any personal repository.

**2. Making TLS certificates on the fly**
Angle: a local CA, leaf generation per host, and getting the operating system to trust it.
Source: the same README line, plus `SHMOXY_CERT_DIR` in the shell configuration of the machine
setup.

**3. Streaming bodies you also want to inspect**
Angle: bounded inspection buffers and backpressure. Do not hold a large upload in memory.
Source: PR #344, "Stream proxy bodies with bounded inspection and optional frontend", 2026-07-24.

**4. The inspection stream that died when the proxy was idle**
Angle: a debugging story. An idle timeout, a keepalive, and a wrong assumption about who closes
the connection.
Source: PR #345, "Fix inspection stream dying permanently when the proxy is idle", 2026-07-28.

**5. Saving and diffing two HTTP traces**
Angle: the data model that makes a side-by-side diff of two captures possible.
Source: PR #340, "Saved Traces view — save/unsave individual traces, with notes", and PR #342,
"compare two saved traces side by side (diff view)", both 2026-07-15.

**6. What interception teaches you about connection reuse**
Angle: keep-alive and pooling. One proxy defect presents as ten application defects.
Inferred. No single commit. It follows from the work in items 3 and 4.

## Interpreters — from `cslox`

**7. Writing Lox in C#**
Angle: what *Crafting Interpreters* leaves to the reader when the host language is not Java.
Source: repository description, "Implementation of Lox interpreter in C#". 57 commits since March.

**8. Resolving `this` before the program runs**
Angle: static scope analysis as its own pass, and why the resolver earns its place.
Source: commits "keyword this supported" and "Get/Set on Classes working", 2026-09-10.

**9. The error message that paid for itself**
Angle: reject a wrong program early instead of failing strangely at run time.
Source: commit "Prevent 'this' being used outside of classes", 2026-09-10.

**10. Testing a tree-walk interpreter**
Angle: golden files against unit tests, and what each kind catches.
Partly inferred. The commit "modified test" (2026-09-10) shows a test suite exists. The comparison
is mine.

## Durable workflows and modules — from `dbos-transact-csharp` and `orian`

**11. Porting a Java library to C# without writing Java**
Angle: where an idiomatic port must break from the reference implementation.
Source: `dbos-transact-csharp/README.md`, "A C#/.NET port of dbos-transact-java... the API closely
mirrors the Java reference implementation". 52 commits since March.

**12. What a durable workflow stores in the database**
Angle: the tables, the recovery path, and the price of "exactly once".
Inferred from the purpose of the library. No single commit. You have the knowledge to write it.

**13. Durable tools for an AI agent**
Angle: an agent whose tool calls survive a process restart.
Source: PR #63, "feat(semantic-kernel): durable AI agent tools (Dbos.Transact.SemanticKernel)",
2026-05-05.

**14. Shipping alpha packages you are not proud of yet**
Angle: alpha versioning, telling users what is unfinished, and keeping the README honest.
Source: PR #60, which bumps the README package versions and adds a rule to keep the README in sync;
PR #57, "downgrade target framework to net8.0", 2026-05-04.

**15. Module contracts before module code**
Angle: define the registry, the context and the manifest first. Write features second.
Source: `orian` PR #18, "Define module system contracts: IOrianModule, IModuleContext,
IModuleRegistry, ModuleManifest", 2026-06-17.

## Postgres and sharding — from `orian` and reading notes

**16. Logical shards as PostgreSQL schemas**
Angle: many logical shards on few machines, and how routing stays simple.
Source: notes page `logical-sharding-via-schemas`, 2026-06-17, marked medium confidence.

**17. Putting the shard id inside the primary key**
Angle: the 41/13/10 bit layout, and what it buys you at read time.
Source: notes page `shard-id-in-primary-key`, 2026-06-17.

**18. Moving a shard with streaming replication**
Angle: the cut-over procedure, step by step, with the failure points marked.
Source: the Instagram sharding reading notes, 2026-06-17, which describe shard moves through
streaming replication.

**19. Familiarity is a scaling strategy**
Angle: the case for boring databases, argued against the usual advice.
Source: the same reading notes, which record the "2.5 engineers" thesis. This is the contrarian
piece of the group.

**Group context:** `orian` PR #20 added multi-server shard routing on 2026-06-17, the same day as
the notes. The theory and the implementation happened together, which is what makes the series
credible.

## Coding-agent evaluation — from the eval repositories

**20. What an agent eval suite must contain to mean anything**
Angle: task selection, grading criteria, and the tests that only measure your own fixtures.
Source: the eval repositories, active from June to September 2026, and the criteria work in
item 25.

**21. Agent evals on Windows**
Angle: the parts nobody documents. Paths, shells, and a sandbox that is not Linux.
Source: notes page on the Windows eval job, 2026-06-12.

**22. Giving an agent a real machine, safely**
Angle: an SSH sandbox driver. A lease pool, a remote runner, and a staged temporary directory.
Source: the sandbox driver design notes, 2026-06-16, which name exactly those parts.

**23. One suite, two targets**
Angle: the same tasks against a managed cloud service and an on-premises install.
Source: the opt-in target mode merged 2026-09-02.

**24. Diffing two eval runs**
Angle: two runs of one suite on two targets. The difference is an environment gap register, not a
model score.
Source: the September 2026 gap register. 138 failures on one target, none on the other, sorted into
18 environment gaps, 7 provisioning warnings and 1 fixture defect.

**25. When eval criteria rot**
Angle: an integrity check for the grading criteria themselves, because the counts drift.
Source: `antigravity_handsoff` commit "Add a criteria integrity check, and correct the criterion
counts", 2026-09-14.

**26. Handing an eval suite to another company**
Angle: one command, a consumer README, and everything the other team cannot ask you at 2 a.m.
Source: `antigravity_handsoff/README.md` ("Package a subset... so another team can run it with one
command") and the commits "Add the handover archive script, with a consumer README inside" and
"Add a zero-cost smoke step, and an explicit first-run order", 2026-09-14.

**27. The cost of a nightly eval**
Angle: wall clock, money, and deciding which runs are worth queueing.
Partly inferred. The nightly pipeline notes from July 2026 exist, but the cost argument is your own
rule about treating pipeline runs as expensive.

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

**31. Memory against context**
Angle: what to write to a file, and what to let the context window forget.
Source: the memory directory under `~/.claude/projects/`, with one fact per file and typed
frontmatter.

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

## Platform war stories — generalize these

**35. CPU limits and throttling**
Angle: a quota on one service became an outage that looked like a deadlock.
Source: work notes, August 2026.

**36. The routing rule that matched only numbers**
Angle: a path pattern accepted numeric identifiers. The real identifiers were GUIDs. Everything
returned the wrong service.
Source: work notes, September 2026. The strongest war story of the six, because the root cause is
one regular expression.

**37. Propagating a trace header through a mesh you do not own**
Angle: where the header is dropped, and how to prove where.
Source: work notes, June 2026, on trace propagation coverage.

**38. Reading a support bundle**
Angle: the first ten minutes. Which four files answer most questions.
Source: two work notes pages on support bundle structure and collection, April 2026. The "first ten
minutes" framing is mine.

**39. Liveness probes that restart the wrong thing**
Angle: a restart loop that hid the real dependency failure.
Source: work notes, July 2026.

**40. When the log pipeline is the outage**
Angle: losing the logs exactly when you need them.
Inferred from the work notes on log collection, June 2026. No single incident behind it.

## Test infrastructure — generalize these

**41. Merge gates built on flaky tests**
Angle: thresholds over history rather than a single red run, and the argument that convinces people.
Source: work notes on a required-tests framework, April 2026, including the sample-size and
failure-rate thresholds.

**42. Test filtering: what you stop running**
Angle: the rollout, the escape hatches, and the first defect that slips through.
Source: work notes on a test filtering rollout, June 2026.

**43. Snapshot environments and the compatibility cliff**
Angle: pinned environment snapshots, old release branches, and the day they stop matching.
Source: work notes, April 2026.

**44. Canary and stable tags**
Angle: promote an environment, not a build, and let it soak.
Source: work notes on tag promotion, April 2026.

## Machines and money — generalize these

**45. Bare metal against cloud for continuous integration**
Angle: the comparison as a monthly number, plus the operational tax nobody prices.
Source: work notes on a bare-metal fleet and its pricing, April 2026. Remove every figure.

**46. Shut it down by default**
Angle: automatic shutdown and deletion of idle resources, with an opt-out that people accept.
Source: work notes on scheduled shutdown and resource-group deletion, May 2026.

## Security and bounties — from `cyber-bounties`

**47. Choosing bug bounty programs by expected value**
Angle: 19 programs surveyed. Most are not worth an evening.
Source: commits CB000001, "survey 19 bug bounty programs and the 2026 market shift", and CB000003,
"drop non-paying programs from targets", 2026-08-27.

**48. Two proxies, one workflow**
Angle: where each tool wins, without ranking them.
Source: commits CB000008 to CB000011, 2026-08-27, which move the default proxy and then correct an
overstated comparison. The correction is the interesting part of the article.

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
* A graph database over repositories and builds, for debugging context. Source: the
  `graph_based_analyzer` repository, April 2026. Memgraph, an ingest command, and six entity types.
* Hugo on GitHub Pages and the subpath traps. Source: this site, September 2026.
* Keeping drafts outside the content directory. Source: `config/development/hugo.toml` in this
  repository.
