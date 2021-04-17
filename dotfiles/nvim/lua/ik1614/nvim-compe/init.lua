vim.o.completeopt = "menuone,noinsert,noselect"

require'compe'.setup {
    enabled = O.auto_complete,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'disable',  -- FIXME: as I understand, this should disable autoselect from popup menu, but it doesn't
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        path = {
            kind = "  "
        },
        buffer = {
            kind = "  "
        },
        calc = {
            kind = "  "
        },
        vsnip = {
            kind = "  "
        },
        nvim_lsp = {
            kind = "  "
        },
        -- nvim_lua = {kind = "  "},
        nvim_lua = false,
        spell = {
            kind = "  "
        },
        tags = false,
        -- snippets_nvim = {kind = "  "},
        -- ultisnips = {kind = "  "},
        -- treesitter = {kind = "  "},
        emoji = {
            kind = " ﲃ ", filetypes={"markdown"
        }}
    }
}

-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- ﬘
-- 
-- 
-- 
-- m
-- 
-- 
-- 
-- 
