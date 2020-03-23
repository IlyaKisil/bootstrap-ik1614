# Bootstrap configs
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://github.com/IlyaKisil)

This repository contains various configuration file and scripts for quick setup of a working environment.

Ideally, bootstrap configurations should be idempotent. That is, the installer should be able to be run multiple times without causing any problems. This makes a lot of things easier to do (in particular, syncing updates between machines becomes really easy).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

## Table of Contents
Generated with [DocToc](https://github.com/thlorenz/doctoc)

Last Update: 2020-03-23

- [Quick setups](#quick-setups)
  - [Setup dotfiles](#setup-dotfiles)
  - [Setup iTerm](#setup-iterm)
- [Overview of this configuration files and scripts](#overview-of-this-configuration-files-and-scripts)
  - [dotfiles](#dotfiles)
  - [dotfiles-meta](#dotfiles-meta)
  - [setup-utils](#setup-utils)
  - [bin](#bin)
  - [misc](#misc)
  - [tests](#tests)
- [Development](#development)
- [Reporting problems and issues](#reporting-problems-and-issues)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Quick setups

### Setup dotfiles
```bash
# Apply profile, i.e. a collection of configs
./install-profile default-cli

# Apply selected configs
./install-config git tmux zsh sh-aliases bin
```

### Setup iTerm
My color scheme of choice for iTerm2 is DoomOne with minor custom tweaks, mainly to make background match prompt line. It also makes `zsh-autosuggestions` easily visible, but not without too much of a distraction

## Overview of this configuration files and scripts
### dotfiles
### dotfiles-meta
### setup-utils
### bin
### misc
### tests


## Development
Testing out new configuration can easily be done within Docker.
In this way, you don't risk of accidentally overriding your existing dotfiles of configs.
```bash
make test-install-config
# or
make test-install-profile
```
> :exclamation: **Important:** Some of the configs are git submodules, i.e. `tpm`, `oh-my-zsh`. However, we don't want our install bash scripts, i.e. `install-profile`, `install-config`,  to pull/update them as a default behaviour, since we don't want to overload different environments. Thus, this should be manged as a stand-alone task within `shell` directive of a config.


## Reporting problems and issues

Please use one of [these forms](https://github.com/IlyaKisil/bootstrap-ik1614/issues/new/choose) which supports `markdown` text formatting. It would also be helpful if you include as much relevant information as possible. This could include screenshots, code snippets etc.



