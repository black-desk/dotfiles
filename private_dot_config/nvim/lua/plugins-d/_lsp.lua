-- https://github.com/neovim/nvim-lspconfig

-- Description:
-- lsp configs for neovim builtin lsp

Capabilities = vim.lsp.protocol.make_client_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
On_Attach_hooks = {}
function On_Attach(client, bufnr)
  local wk = require("which-key")
  local key_opts = {
    -- mode   Help        Affected                              Equivalent
    -- ''     mapmode-nvo Normal/Visual/Select/Operator-pending :map
    -- 'n'    mapmode-n	  Normal                                :nmap
    -- 'v'    mapmode-v   Visual/Select                         :vmap
    -- 's'    mapmode-s	  Select                                :smap
    -- 'x'    mapmode-x	  Visual                                :xmap
    -- 'o'    mapmode-o   Operator-pending                      :omap
    -- '!'    mapmode-ic  Insert/Command-line                   :map!
    -- 'i'    mapmode-i   Insert                                :imap
    -- 'l'    mapmode-l   Insert/Command-line/Lang-Arg          :lmap
    -- 'c'    mapmode-c   Command-line                          :cmap
    -- 't'    mapmode-t   Terminal                              :tmap
    mode    = "n",
    buffer  = 0, -- local mappings
    silent  = true, -- use `silent ` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
  }

  wk.register(
    {
      ["K"] = {
        "<cmd>lua vim.lsp.buf.hover()<CR>",
        "LSP:: hover" },
      ["<C-k>"] = {
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        "LSP:: signature help" },
      ["<space>rn"] = {
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        "LSP:: rename" },
      ["<space>f"] = {
        "<cmd>lua vim.lsp.buf.formatting()<CR>",
        "LSP:: format" },
      ["<space>E"] = {
        "<cmd>lua vim.diagnostic.open_float()<CR>",
        "LSP:: float diagnostic" },
      ["<space>a"] = {
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        "LSP:: code action" },
    },
    key_opts
  )

  key_opts = {
    mode    = "n",
    buffer  = 0, -- local mappings
    silent  = true, -- use `silent ` when creating keymaps
    noremap = false, -- not use `noremap` when creating keymaps
  }

  wk.register(
    {
      ["gd"] = {
        "<cmd>lua vim.lsp.buf.definition()<cr>",
        "LSP:: definition" },
      ["gr"] = {
        "<cmd>lua vim.lsp.buf.references()<cr>",
        "LSP:: reference" },
      ["gi"] = {
        "<cmd>lua vim.lsp.buf.implementation()<cr>",
        "LSP:: implementation" },
      ["gy"] = {
        "<cmd>lua vim.lsp.buf.type_definition()<cr>",
        "LSP:: type definition" },
    },
    key_opts
  )

  for _, hook in ipairs(On_Attach_hooks) do
    if hook ~= nil then
      hook(client, bufnr)
    end
  end
end

local function config()

  local installer_servers = {
    'bashls',
    'clangd',
    'gopls',
    'jsonls',
    'pyright',
    'tsserver',
    'texlab',
  }

  require("nvim-lsp-installer").setup({
    ensure_installed = installer_servers,
    automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  })

  local nvim_lsp = require('lspconfig')

  local extra_servers = {
    'mdlsp'
  }

  local servers = {}

  for _, server in ipairs(installer_servers) do
    table.insert(servers, server)
  end

  for _, server in ipairs(extra_servers) do
    table.insert(servers, server)
  end

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  for _, lsp in ipairs(servers) do
    local default = {
      flags = {
        debounce_text_changes = nil,
      },
      on_attach = On_Attach,
      capabilities = Capabilities
    }

    local cfg = vim.tbl_deep_extend('force', default, require('lsp-d/' .. lsp .. '_'))
    nvim_lsp[lsp].setup(cfg)
  end
end

return {
  'black-desk/nvim-lspconfig',
  config = config,
  after = {
    'nvim-cmp',
  },
  requires = {
    'williamboman/nvim-lsp-installer',
  }
}
