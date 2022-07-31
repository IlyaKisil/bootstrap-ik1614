local refactoring = require("refactoring")
refactoring.setup({})

-- telescope refactoring helper
local function telescope_refactor(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )
    require("telescope.actions").close(prompt_bufnr)
    refactoring.refactor(content.value)
end


local M = {}

M.refactors = function()
    -- local opts = require("telescope.themes").get_cursor() -- set personal telescope options
    local opts = {}

    require("telescope.pickers").new(opts, {
        prompt_title = "Refactors",
        finder = require("telescope.finders").new_table({
            results = refactoring.get_refactors(),
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(_, map)
            map("i", "<CR>", telescope_refactor)
            map("n", "<CR>", telescope_refactor)
            return true
        end
    }):find()
end

return M
