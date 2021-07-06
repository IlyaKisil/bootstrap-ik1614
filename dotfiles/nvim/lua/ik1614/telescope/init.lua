if not pcall(require, 'telescope') then
  return
end

local reloader = function()
    RELOAD('plenary')
    RELOAD('popup')
    RELOAD('telescope')
end

reloader()

local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = '> ',
        prompt_position = "top",
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        winblend = 0,
        width = 1,
        results_width = 1,
        color_devicons = true,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        layout_strategy = "flex",
        layout_defaults = {
            horizontal = {
                width_padding = 4,
                height_padding = 2,
                mirror = false,
            },
            vertical = {
                width_padding = 4,
                height_padding = 2,
                mirror = false,
            },
        },

        mappings = {
            i = {
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-m>"] = actions.move_selection_previous,
                ["<C-k>"] = actions.move_selection_previous,
                ["<CR>"] = actions.select_default + actions.center,
                -- ["<esc>"] = actions.close,
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}

-- require('telescope').load_extension('fzy_native')

local M = {}
function M.search_dotfiles()
    require("telescope.builtin").find_files({
        prompt_title = "< dotfiles >",
        cwd = "$HOME/GitHub/IlyaKisil/bootstrap-ik1614/dotfiles/",
    })
end

function M.git_branches()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
