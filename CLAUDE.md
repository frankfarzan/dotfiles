# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for a macOS/Linux shell environment. There is no build, test, or
lint step — files here are configuration that get checked out directly into `$HOME`.
Editing a file *is* the change; "deploying" it means it lives at the corresponding
path under `$HOME`.

## Fresh-machine setup

- `Brewfile` — declarative list of developer tooling (`brew bundle`-format). Grows over
  time; add a line and re-run. Idempotent.
- `bootstrap.sh` — idempotent one-shot: installs Homebrew → runs `brew bundle` against
  `Brewfile` → installs oh-my-zsh and the plugins/theme `.zshrc` expects. Run with
  `./bootstrap.sh`. Deploying dotfiles into `$HOME` (the bare-repo checkout) stays manual
  because it moves existing files — see `.README.md`.

When adding a tool that a dotfile depends on, add it to `Brewfile` so a fresh machine
stays reproducible.

## Bare-repo management model

This is **not** a normal repo cloned into a working directory. In production it is a
bare repo at `$HOME/.dotfiles` with the work tree set to `$HOME`, driven by:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

So `config status` / `config add` / `config commit` operate on dotfiles in place
without turning all of `$HOME` into a tracked tree (`status.showUntrackedFiles` is set
to `no`). Setup steps (bare clone, oh-my-zsh install, plugin/theme installation) are in
`.README.md`.

Note: `git status` in *this* checkout (`/Users/frank/code/dotfiles`) is a regular clone
used for editing. The `config` alias is how the same content is managed when deployed to
`$HOME`.

## Files and their dependencies

- `.zshrc` — assumes oh-my-zsh is installed, plus these external plugins/theme that
  must be cloned separately (see `.README.md`): `zsh-autosuggestions`,
  `zsh-syntax-highlighting`, `powerlevel10k`. Also expects `fzf`, `z`, and (optionally)
  the Google Cloud SDK at `/opt/google-cloud-sdk`. Falls back to the `robbyrussell`
  theme when running inside Cursor (`$CURSOR_TRACE_ID`).
- `.p10k.zsh` — generated powerlevel10k config (large, machine-generated). Edit via
  `p10k configure` rather than by hand.
- `.vimrc`, `.tmux.conf` — standalone, no plugin managers.
- `.gitignore` ignores `*.sw*` and `.dotfiles`.

## Conventions worth preserving

- **vi-mode everywhere**: zsh (`vi-mode` plugin), tmux (`mode-keys vi`), and vim. tmux
  uses `C-a` as prefix and vim-style (`hjkl`) pane navigation, including Alt+hjkl
  without prefix.
- **Indentation**: vim defaults to 4-space expandtab; YAML overrides to 2-space; Go
  uses tabs/wide textwidth (see the filetype `au` blocks in `.vimrc`).
- Aliases in `.zshrc` are short single-letters (`g`=git, `k`=kubectl, `j`=just,
  `c`=clear) plus `config` for the bare-repo workflow. Add new ones in the ALIASES block.

When adding a new dotfile, place it at the path it should occupy relative to `$HOME`
(e.g. `.config/foo/bar`), since the work tree is `$HOME`.
