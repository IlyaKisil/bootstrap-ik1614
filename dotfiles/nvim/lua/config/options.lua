-- ======================================================================================
--
-- Default options that are set by LazyVim distro
-- * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--
-- ======================================================================================

-- vim.g.lazyvim_picker = "fzf"

-- Show special characters
vim.opt.listchars = {
  nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = "-->",
  space = ".",
}
