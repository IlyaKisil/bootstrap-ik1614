# What This Repo Is

A personal dotfiles and environment bootstrap system. It uses [Dotbot](https://github.com/anishathalye/dotbot) to symlink config files and run setup shell commands. Scripts are designed to be idempotent — safe to re-run multiple times.

# Key Commands

```bash
# Install individual configs
./install-config.sh git tmux zsh sh-aliases bin

# Install a preset profile (collection of configs)
./install-profile.sh default-cli   

# Update all git submodules
make update-submodules

# List all make targets
make help
```

**Prerequisite before first install:** `pip install pyyaml`

# Architecture

## Configuration Layer

- `dotfiles-meta/base.yaml` — base Dotbot config with shared defaults (`create: true`, `relink: true` for all links)
- `dotfiles-meta/configs/<tool>.yaml` — per-tool config: what to symlink and what shell commands to run
- `dotfiles-meta/profiles/<name>` — plain-text list of config names that form a profile

`install-config.sh` merges `base.yaml` with each per-tool YAML into a temp file and passes it to Dotbot. `install-profile.sh` just reads a profile file and delegates to `install-config.sh`.

## Dotfiles

Live under `dotfiles/<tool>/`. Each tool may define a `-local` variant for machine-specific overrides (e.g. `~/.zshrc-local`, `~/.gitconfig-local`, `~/.tmux-local.conf`). On first install these are **copied** (not symlinked) to the target location, so they are standalone files that will not receive future updates from this repo. To pick up upstream changes to a local template, delete the file and re-run the install.

## Git Submodules

Used for Dotbot itself, oh-my-zsh, powerlevel10k, fzf-tab, and tmux TPM. Submodules are **not** auto-initialized during install to avoid overloading environments — each tool's YAML shell directive initializes only what it needs.

## Bash Module System

`bin/bash-modules/` contains reusable shell libraries (colors, tmux, utils). Convention: functions are namespaced as `module::function`. Scripts source these via `import_ik1614_module`.

## Platform-Specific Setup

`setup-utils/darwin/` contains macOS Brewfiles and `defaults` commands. `setup-utils/debian/` covers Linux. `setup-utils/common/` has cross-platform scripts.

# Neovim Config

Lives under `dotfiles/nvim/`. Built on [LazyVim](https://www.lazyvim.org/) as the distro layer on top of lazy.nvim.

## Key Directories

- `lua/config/` — core setup loaded at startup: `lazy.lua` (plugin manager bootstrap), `options.lua`, `keymaps.lua`, `autocmds.lua`
- `lua/plugins/` — plugin specs that add new plugins or override LazyVim defaults
- `lua/ik1614/` — personal code: helper functions (`functions/`) and snippets (`snippets/`)
- `after/ftplugin/` — filetype-specific settings (Go, Python, Terraform, Markdown, TeX, etc.)
- `after/queries/` — Treesitter query overrides, including a custom `env-tmpl` language
- `lazyvim.json` — LazyVim extras (language packs, coding tools) enabled for this config

## Conventions

- **Adding a plugin:** create a spec file under `lua/plugins/`. To override a LazyVim default, use the same plugin name in the spec.
- **Personal helpers/functions:** add under `lua/ik1614/functions/`, not in `lua/plugins/` or `lua/config/`.
- **Keymaps:** use the helper in `lua/ik1614/functions/mapping.lua` — it wraps `vim.keymap.set` with mode-specific methods (`.n()`, `.i()`, `.v()`, `.buf_n()`, etc.).
- **LazyVim extras:** managed via `:LazyExtras` UI, which writes to `lazyvim.json` — don't edit that file by hand.

# Adding a New Tool Config

1. Add dotfiles under `dotfiles/<tool>/`
2. Create `dotfiles-meta/configs/<tool>.yaml` with `link` and optionally `shell` directives
3. Add the tool name to any relevant profile files under `dotfiles-meta/profiles/`
4. Test with `./install-config.sh <tool>` or via Docker
