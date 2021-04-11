# NeoVim
In general, I try to switch all configs to `lua`. This also means that I want switch not
only configs to it but also use plugins written in `lua` as well. However, there are some
plugins that I got used to or it will take some time to transition/convert their
configurations. However, NVIM doesn't currently provide interface for certain features of
VIM which makes it more difficult , e.g.

* Defining user commands
* Defining autocommands
* Defining syntax/highlights

Nevertheless, I adopt `lua` first approach and use VimScript only as a last resort. Thus,
all configurations should be specified in
```
lua/ik1614/init.lua

lua/ik1614-vimscript/init.vim
```

## References
* Switching to `init.lua` https://oroques.dev/notes/neovim-init/



Plugins that are written with VimScript would normally provide setup/configuartion
samples in a form of VimScript. However, I try to keep all configs for NVIM in `lua`.
Thus, in situations when there is not enough time to properly convert those boilerplate
configs to it, the following pattern can be used:
```lua
vim.cmd([[
  Paste config here
]])
```
