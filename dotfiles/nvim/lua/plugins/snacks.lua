--[[
Interesting options to discover  
* inspect
* jump
* pick_win
-- ]]

local picker_win_input_default_keys = {
  ["/"] = "toggle_focus",
  ["<CR>"] = { "confirm", mode = { "n", "i" } },
  ["<Esc>"] = false, -- "cancel",
  ["<S-CR>"] = false,
  ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
  ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
  ["<Down>"] = { "list_down", mode = { "i", "n" } },
  ["<Up>"] = { "list_up", mode = { "i", "n" } },
  ["<c-Down>"] = false,
  ["<c-Up>"] = false,
  --
  ["<a-d>"] = false,
  ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
  ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
  ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
  ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
  ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
  ["<a-w>"] = false,
  --
  ["<c-a>"] = false,
  ["<c-b>"] = false,
  ["<c-c>"] = { "cancel", mode = { "i", "n" } },
  ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
  ["<c-f>"] = false,
  ["<c-g>"] = false,
  ["<c-j>"] = false,
  ["<c-k>"] = false,
  ["<c-n>"] = { "list_down", mode = { "i", "n" } },
  ["<c-o>"] = { "select_all", mode = { "i", "n" } },
  ["<c-p>"] = { "list_up", mode = { "i", "n" } },
  ["<c-q>"] = { "qflist", mode = { "i", "n" } },
  ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
  ["<c-t>"] = { "tab", mode = { "n", "i" } },
  ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
  ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
  ["<c-w>"] = { "cycle_win", mode = { "i", "n" } },
  --
  ["?"] = "toggle_help_input",
  ["G"] = "list_bottom",
  ["gg"] = "list_top",
  ["j"] = "list_down",
  ["k"] = "list_up",
  ["q"] = "close",
  --
  ["<c-r>#"] = false,
  ["<c-r>%"] = false,
  ["<c-r><c-a>"] = false,
  ["<c-r><c-f>"] = false,
  ["<c-r><c-l>"] = false,
  ["<c-r><c-p>"] = false,
  ["<c-r><c-w>"] = false,
  ["<c-w>H"] = false,
  ["<c-w>J"] = false,
  ["<c-w>K"] = false,
  ["<c-w>L"] = false,
}

local picker_win_list_default_keys = {
  ["<2-LeftMouse>"] = false,
  ["/"] = "toggle_focus",
  ["<CR>"] = "confirm",
  ["<Esc>"] = false, -- "cancel",
  ["<S-CR>"] = false,
  ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
  ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
  ["<Down>"] = "list_down",
  ["<Up>"] = "list_up",
  --
  ["<a-d>"] = false,
  ["<a-f>"] = "toggle_follow",
  ["<a-h>"] = "toggle_hidden",
  ["<a-i>"] = "toggle_ignored",
  ["<a-m>"] = "toggle_maximize",
  ["<a-p>"] = "toggle_preview",
  ["<a-w>"] = false,
  --
  ["<c-a>"] = false,
  ["<c-b>"] = false,
  ["<c-c>"] = "cancel",
  ["<c-d>"] = "preview_scroll_down",
  ["<c-f>"] = false,
  ["<c-g>"] = false,
  ["<c-j>"] = false,
  ["<c-k>"] = false,
  ["<c-n>"] = "list_down",
  ["<c-o>"] = "select_all",
  ["<c-p>"] = "list_up",
  ["<c-q>"] = "qflist",
  ["<c-s>"] = "edit_split",
  ["<c-t>"] = "tab",
  ["<c-u>"] = "preview_scroll_up",
  ["<c-v>"] = "edit_vsplit",
  ["<c-w>"] = "cycle_win",
  --
  ["?"] = "toggle_help_list",
  ["G"] = "list_bottom",
  ["gg"] = "list_top",
  ["i"] = "focus_input",
  ["j"] = "list_down",
  ["k"] = "list_up",
  ["q"] = "close",
  ["zb"] = "list_scroll_bottom",
  ["zt"] = "list_scroll_top",
  ["zz"] = "list_scroll_center",
  --
  ["<c-w>H"] = false,
  ["<c-w>J"] = false,
  ["<c-w>K"] = false,
  ["<c-w>L"] = false,
}

local picker_win_preview_default_keys = {
  ["<Esc>"] = false, -- "cancel",
  ["q"] = "close",
  ["i"] = "focus_input",
  ["<a-w>"] = false,
  ["<c-c>"] = "cancel",
  ["<c-w>"] = "cycle_win",
}

return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.scroll = { enabled = false }
      opts.indent = { enabled = false }
      opts.explorer = { enabled = false }
      opts.dashboard = { enabled = false }
      opts.picker = {
        enabled = true,
        formatters = {
          file = {
            truncate = 200,
          },
        },
        icons = {
          files = {
            enabled = false,
          },
        },
        win = {
          input = {
            keys = picker_win_input_default_keys,
          },
          list = {
            keys = picker_win_list_default_keys,
          },
          preview = {
            keys = picker_win_preview_default_keys,
          },
        },
      }
    end,
  },
}
