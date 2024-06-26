vim.g.dashboard_default_executive = "telescope"

vim.g.dashboard_custom_section = {
  a = {
    description = { "  Find File          " },
    command = "Telescope find_files",
  },
  b = {
    description = { "  Recently Used Files" },
    command = "Telescope oldfiles",
  },
  c = {
    description = { "  Load Last Session  " },
    command = "SessionLoad",
  },
  d = {
    description = { "  Find Word          " },
    command = "Telescope live_grep",
  },
}

-- vim.g.dashboard_session_directory = '~/.cache/nvim/session'
vim.g.dashboard_custom_footer = { "" }
