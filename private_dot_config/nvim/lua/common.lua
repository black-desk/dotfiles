vim.api.nvim_set_option('ignorecase', true)

-- tab size
-- FIXME use lua here
vim.cmd([[
  set updatetime=100
  set number
  set relativenumber
  set mouse=a
  set expandtab tabstop=2 shiftwidth=2 softtabstop=2
  au Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  au Filetype sh setlocal tabstop=4 shiftwidth=4 softtabstop=4
  au Filetype zsh setlocal tabstop=4 shiftwidth=4 softtabstop=4
  au Filetype c setlocal tabstop=8 shiftwidth=4 softtabstop=8
  au FileType json setlocal tabstop=4 shiftwidth=4 softtabstop=4
  au FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
  set cursorline " current line
  set hlsearch   " searched key word
  set colorcolumn=81
  set signcolumn=yes
  au Filetype gitcommit setlocal colorcolumn=72
  au Filetype go setlocal colorcolumn=""
  au Filetype markdown setlocal colorcolumn=""
]])

vim.g.markdown_fenced_languages = {'c','go','cpp','coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml'}
