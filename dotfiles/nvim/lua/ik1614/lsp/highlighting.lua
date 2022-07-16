return {
  setup = function(client) -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      -- NOTE(ilya): Sometimes shadows yank highlight area. Typically this happens if you
      -- need to yank the same thing again without cursor being moved :shrug:
      vim.cmd [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]]
      -- require("illuminate").on_attach(client)
    end
  end,
}
