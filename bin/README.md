:exclamation: **Important:** This directory is symlinked, don't keep any sensitive info here :exclamation:

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

## Table of Contents
Generated with [DocToc](https://github.com/thlorenz/doctoc)

Last Update: 2021-02-08

- [Overview](#overview)
- [Reusable modules](#reusable-modules)
  - [Available modules](#available-modules)
- [Custom scripts](#custom-scripts)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Overview
Directory with custom scripts which can be executed directly from shell, since this
directory is added to `$PATH`. Most of the scripts can display help message
`some_script.sh -h` or `some_script.sh --help` which provides more detailed information
and use cases.

In order to decrease chances of this scripts names shadowing system names/packages, it is
advised to use extension `.sh`

## Reusable modules
Functions that can be reused in different scripts can be found in
[bash-modules](./bash-modules). In order to 'import' them/their
```bash
source import_ik1614_module __MODULE_NAME__
```
where `__MODULE_NAME__` is a file name in `./bash-modules/*`.

Namespacing is done on the function level within the module, i.e.
functions should start with name of the module followed by double
colon.

### Available modules
- `colors`
- `tmux`
- `utils`

## Custom scripts
- `import_ik1614_module`
- `make-pdf.sh`
- `start-jupyter.sh`
- `re.sh`
- `add-secret-environment-variable.sh`
- `load-secret-environment-variable.sh`
