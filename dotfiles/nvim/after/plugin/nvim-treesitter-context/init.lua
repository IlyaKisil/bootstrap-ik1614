-- local f = require("ik1614.functions")
-- local plugin_name = "treesitter-context"

-- if not f.utils:plugin_installed(plugin_name) then
--   return
-- end

-- local plugin = require(plugin_name)
-- plugin.setup({
--     enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--     throttle = true, -- Throttles plugin updates (may improve performance)
--     max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--     -- trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--     -- min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--     patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
--         -- For all filetypes
--         -- Note that setting an entry here replaces all other patterns for this entry.
--         -- By setting the 'default' entry below, you can control which nodes you want to
--         -- appear in the context window.
--         default = {
--             'class',
--             'function',
--             'method',
--             'for',
--             'while',
--             'if',
--             'switch',
--             'case',
--         },
--         -- Patterns for specific filetypes
--         -- If a pattern is missing, *open a PR* so everyone can benefit.
--         tex = {
--             'chapter',
--             'section',
--             'subsection',
--             'subsubsection',
--         },
--         rust = {
--             'impl_item',
--             'struct',
--             'enum',
--         },
--         markdown = {
--             'section',
--         },
--         json = {
--             'pair',
--         },
--         yaml = {
--             'block_mapping_pair',
--         },
--     },
--     exact_patterns = {
--         -- Example for a specific filetype with Lua patterns
--         -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
--         -- exactly match "impl_item" only)
--         -- rust = true,
--     },
-- })
