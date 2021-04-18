if not pcall(require, 'telescope') then
  return
end

local map = function(key, f, options, buffer)
  local mode = "n"
  local rhs = string.format(
    "<cmd>lua R('ik1614.telescope')['%s']()<CR>",
    f
  )

  -- FIXME: To pass some options to a telescope function but this Doesn't work :cry:
  -- local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)
  -- TelescopeMapArgs[map_key] = options or {}
  -- local rhs = string.format(
  --   "<cmd>lua R('ik1614.telescope')['%s'](TelescopeMapArgs['%s'])<CR>",
  --   f,
  --   map_key
  -- )

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end


-- map('<leader>oo', 'find_files')
-- map('<leader>tt', 'search_dotfiles')
