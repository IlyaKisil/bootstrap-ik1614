# Bootstrap configs
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://github.com/IlyaKisil)

This repository contains various configuration file and scripts for quick setup of a
working environment.

Ideally, bootstrap configurations should be idempotent. That is, the installer should be
able to be run multiple times without causing any problems. This makes a lot of things
easier to do (in particular, syncing updates between machines becomes really easy).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

## Table of Contents
Generated with [DocToc](https://github.com/thlorenz/doctoc)

Last Update: 2024-06-17

- [Quick setups](#quick-setups)
  - [Setup dotfiles](#setup-dotfiles)
  - [Setup iTerm2](#setup-iterm2)
- [Post install actions](#post-install-actions)
  - [Nvim](#nvim)
  - [Useful npm packages](#useful-npm-packages)
  - [`gcloud`](#gcloud)
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

# Quick setups

> [!IMPORTANT]
> You need to have `PyYAML` installed before trying to install profile or configuration.
>
> ```bash
> pip install pyyaml
> ```

```bash
git clone https://github.com/IlyaKisil/bootstrap-ik1614.git
cd bootstrap-ik1614

# Apply profile, i.e. a collection of configs
./install-profile.sh default-cli

# Apply selected configs
./install-config.sh git tmux zsh sh-aliases bin
```

# Optional post install actions
## Python
Install whatever versions of Python you need with `pyenv`
```bash
pyenv install 3.9.4
pyenv global 3.9.4
```


## Node
> [!IMPORTANT]
> NVM is not imported by default because it increases shell start up time. It is likely
> that you would need to comment out `NODE_VERSION` env variable in the `~/.zshrc-local`.
> In general, see `~/.zshrc` for more info.

```bash
nvm install --lts --default
```
Useful `npm` packages
```
├── commitizen@4.0.3
├── conventional-changelog-cli@2.1.1
├── cz-conventional-changelog@3.1.0
├── gemini-cli
├── doctoc@1.4.0
├── standard-version@9.3.0
└── wscat@4.0.0
```


## Nvim
Check health and adjust accordingly.
```bash
nvim -c ':checkhealth'
```

For example, you might need to install missing providers
```bash
pip install pynvim

nvm install node
npm install -g neovim
```


## Configure `gcloud`
```bash
gcloud init ...

gcloud components install cloud_sql_proxy

gcloud auth application-default login
```


# Overview of this configuration files and scripts
## dotfiles
## dotfiles-meta
## setup-utils
## bin
## misc
## tests



# Development
Testing out new configuration can easily be done within Docker.
In this way, you don't risk of accidentally overriding your existing dotfiles of configs.
```bash
make test-install-config
# or
make test-install-profile
```
> [!IMPORTANT]
> Some of the configs are git submodules, i.e. `tpm`, `oh-my-zsh`. However, we don't want
> our install bash scripts, i.e. `install-profile`, `install-config`,  to pull/update
> them as a default behaviour, since we don't want to overload different environments.
> Thus, this should be manged as a stand-alone task within `shell` directive of a config.



# Reporting problems and issues
Please use one of [these forms][this-repo-issues] which supports `markdown` text
formatting. It would also be helpful if you include as much relevant information as
possible. This could include screenshots, code snippets etc.



<!-- References -->
[this-repo-issues]: https://github.com/IlyaKisil/bootstrap-ik1614/issues/new/choose
