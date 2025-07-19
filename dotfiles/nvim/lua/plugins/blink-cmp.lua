return {
  {
    "https://github.com/saghen/blink.cmp",
    opts = function(_, opts)
      -- Disable completely for certail file types
      opts.enabled = function()
        local disabled_filetypes = {}

        local filetype = vim.bo[0].filetype
        for _, ft in ipairs(disabled_filetypes) do
          if filetype == ft then
            return false
          end
        end
        return true
      end

      opts.snippets.preset = "luasnip"

      -- Not really a fun of icons ('kind_icon') as they are ambigious
      opts.completion.menu.draw.columns =
        { { "label", "label_description", gap = 1 }, { "source_name", "kind", gap = 1 } }

      -- Never liked this as it constanty moves things around
      opts.completion.ghost_text.enabled = false

      opts.completion.list = { selection = { preselect = true, auto_insert = false } }

      -- Merge custom sources with the existing ones from lazyvim
      -- * Snippets Provider -> There is a nice idea to add prefix, e.g. ';', to all
      --   triggers for all snippets, and then removing trigger text characters.
      --   References
      --   * https://github.com/linkarzu/dotfiles-latest/blob/a9a8dd3f2a9b91236300522324ebc71a30412600/neovim/neobean/lua/plugins/luasnip.lua#L17-L25
      --   * https://github.com/linkarzu/dotfiles-latest/blob/a9a8dd3f2a9b91236300522324ebc71a30412600/neovim/neobean/lua/plugins/blink-cmp.lua#L91-L137
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        min_keyword_length = 2, -- Minimum number of characters in the keyword to trigger all providers
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          lsp = {
            -- name = "LSP",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            -- kind = "LSP",
            score_offset = 90, -- the higher the number, the higher the priority
          },
          buffer = {
            name = "Buffer",
            enabled = true,
            max_items = 5,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 5,
            score_offset = 15, -- the higher the number, the higher the priority
          },
          copilot = {
            name = "Copilot",
            module = "blink-cmp-copilot",
            kind = "Copilot",
            score_offset = 10,
            async = true,
          },
        },
      })

      opts.keymap = {
        preset = "none",
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        -- ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "select_prev", "fallback" },

        ["<Down>"] = { "select_next", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        -- ["<CR>"] = { "select_and_accept" },
        ["<C-y>"] = { "select_and_accept" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-c>"] = { "hide", "fallback" },
      }
    end,
  },
}
