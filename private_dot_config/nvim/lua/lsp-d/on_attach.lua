-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
return function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- require('illuminate').on_attach(client)
  -- vim.api.nvim_command [[ hi def LspReferenceText gui=bold cterm=bold ]]
  -- vim.api.nvim_command [[ hi def LspReferenceRead gui=underline,bold cterm=underline,bold ]]
  -- vim.api.nvim_command [[ hi def LspReferenceWrite gui=underline,bold,italic cterm=underline,bold,italic ]]
end

