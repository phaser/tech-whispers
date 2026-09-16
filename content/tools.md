+++
title = "Tools I Use"
date = "2026-09-16"
description = "The terminal tools, editors and command line helpers I install on a new machine, taken from my nix-darwin configuration."
+++

*Updated: 16 Sep, 2026. This page is a work in progress.*

Most of this list is not from memory. It is what my nix-darwin configuration installs on both of my
machines. If a tool is here, it is on every Mac I use.

## Terminal tools

* [Ghostty](https://ghostty.org/) — my terminal. Fast, and it does not need a configuration file to be usable.
* [tmux](https://github.com/tmux/tmux/wiki) — terminal multiplexer. It keeps my sessions alive between connections.
* [nvim with LazyVim](https://www.lazyvim.org/) — my main editor. LazyVim gives it a complete configuration out of the box.
* [Vim](https://www.vim.org/) — when I'm in a hurry and don't have time to set up LazyVim.

### Oh My Themes

I want my terminal to look good and work well, but I don't want to spend an evening configuring it on every new machine. The "Oh My *" projects give attractive defaults and stay easy to customize.

* [Oh My Tmux](https://github.com/gpakosz/.tmux) — a complete `.tmux.conf`. It got me started. These days my tmux runs Catppuccin instead.
* [Catppuccin](https://github.com/catppuccin/tmux) — the Macchiato flavour, on tmux. CPU, session, uptime and battery in the status bar.
* [Oh My Bash](https://github.com/ohmybash/oh-my-bash) — themes and plugins for bash.
* [Oh My Posh](https://ohmypo.sh/) — a prompt theme engine. It works with any shell.
* [Oh My Zsh](https://ohmyz.sh/) — themes and plugins for zsh. This is the one my Macs run, with the agnoster theme.

### Enhancers

* [delta](https://github.com/dandavison/delta) — a diff pager with syntax highlighting. Git uses it as the pager, side by side, with navigation between files.
* [bat](https://github.com/sharkdp/bat) — `cat` with syntax highlighting and paging.
* [ripgrep](https://github.com/BurntSushi/ripgrep) — grep that respects `.gitignore` and is fast enough that I stopped thinking about it.
* [fzf](https://github.com/junegunn/fzf) — fuzzy finder. It turns any list into a searchable list.
* [zoxide](https://github.com/ajeetdsouza/zoxide) — `cd` that learns the directories I visit.
* [superfile](https://github.com/yorukot/superfile) — a file manager in the terminal, for the times a tree is easier than a path.

## Git

* [git](https://git-scm.com/) with [gh](https://cli.github.com/) and [git-lfs](https://git-lfs.com/).
* [Beyond Compare](https://www.scootersoftware.com/) — my merge tool when a three way conflict stops being readable in the terminal.

My Git defaults come from the same configuration: `pull.rebase`, `fetch.prune`,
`push.autoSetupRemote`, and `zdiff3` conflict style.

## Editors

* [Visual Studio Code](https://code.visualstudio.com/) — rather good at .NET, and lighter than a full IDE.
* [JetBrains Rider](https://www.jetbrains.com/rider/) — for the .NET work that a terminal editor makes slow.

## Build and languages

* [cmake](https://cmake.org/), [ninja](https://ninja-build.org/), `pkg-config`, autotools — the C and C++ base.
* [rustup](https://rustup.rs/) and the .NET SDKs, both installed by a script the configuration runs.
* [PowerShell](https://github.com/PowerShell/PowerShell) — cross platform, and the work I do needs it.
* [bats](https://github.com/bats-core/bats-core) — a test framework for bash. Shell scripts deserve tests too.
* [shellcheck](https://www.shellcheck.net/) — it finds the quoting bug before the script does.
* [statix](https://github.com/oppiliappan/statix) and [nixfmt](https://github.com/NixOS/nixfmt) — lint and format for the Nix files.

## Machines and containers

* [nix-darwin](https://github.com/nix-darwin/nix-darwin) with [Home Manager](https://github.com/nix-community/home-manager) — the whole setup. Two machines, one flake.
* [OrbStack](https://orbstack.dev/) — Docker and Linux virtual machines on macOS, without the fan noise.
* [Tart](https://tart.run/) — macOS virtual machines for CI work.
* [UTM](https://mac.getutm.app/) — everything else that must be virtualized.

## Documents and media

* [Hugo](https://gohugo.io/) — this site.
* [pandoc](https://pandoc.org/) with [mermaid-cli](https://github.com/mermaid-js/mermaid-cli) and MacTeX — Markdown to anything, diagrams included.
* [ffmpeg](https://ffmpeg.org/), [yt-dlp](https://github.com/yt-dlp/yt-dlp), [exiftool](https://exiftool.org/), [ocrmypdf](https://github.com/ocrmypdf/OCRmyPDF) — the media and document toolbox.
* [GIMP](https://www.gimp.org/), [OBS](https://obsproject.com/), [VLC](https://www.videolan.org/).

## Elsewhere on the desktop

* [Raycast](https://www.raycast.com/) — launcher, clipboard history, window management.
* [Firefox](https://www.mozilla.org/firefox/) with uBlock Origin.
* [LM Studio](https://lmstudio.ai/) — local models. I point Claude Code at it when I want to stay offline.
* [jira-cli](https://github.com/ankitpokhrel/jira-cli) and [acli](https://developer.atlassian.com/cloud/acli/) — Jira without the browser.
