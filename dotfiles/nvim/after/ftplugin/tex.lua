vim.opt_local.textwidth = 89
vim.opt_local.linebreak = true
vim.opt_local.wrap = true

vim.cmd([[
  call functions#add_file_header([
              \ '% !TEX root =',
              "\ '% cSpell:ignoreRegExp ^[\s]*%.*',
              "\ '% cSpell:ignoreRegExp \\[0-9a-zA-Z]*',
              "\ '% cSpell:ignoreRegExp .*\\usepackage.*',
              "\ '% cSpell:ignoreRegExp .*\\cite\{[\w:\-,\s]*\}',
              "\ '% cSpell:ignoreRegExp .*\\c?ref\{[\w:\-]*\}',
              "\ '% cSpell:ignoreRegExp .*\\(begin|end){.*}.*',
              \ ])
]])
