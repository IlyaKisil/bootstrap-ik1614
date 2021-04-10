Plugins that are written with VimScript would normally provide setup/configuartion
samples in a form of VimScript. However, I try to keep all configs for NVIM in `lua`.
Thus, in situations when there is not enough time to properly convert those boilerplate
configs to it, the following pattern can be used:
```lua
vim.cmd([[
  Paste config here
]])
```
