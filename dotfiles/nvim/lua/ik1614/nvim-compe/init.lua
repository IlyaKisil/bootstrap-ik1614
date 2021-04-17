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

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

--- Move to prev/next item in completion menuone
--- Jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--     if vim.fn.pumvisible() == 1 then
--         return t "<C-n>"
--     -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
--     --     return t "<Plug>(vsnip-expand-or-jump)"
--     elseif check_back_space() then
--         return t "<C-n>"
--     else
--         return vim.fn['compe#complete']()
--     end
-- end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    --     return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<C-e>"
    end
end

-- On Colemak, I'm ok to use <C-n>
-- vim.api.nvim_set_keymap("i", "<C-n>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<C-n>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-e>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<C-e>", "v:lua.s_tab_complete()", {expr = true})
