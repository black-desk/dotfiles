-- https://github.com/nvim-telescope/telescope.nvim

-- Description:
-- telescope.nvim is a highly extendable fuzzy finder over lists.
-- Built on the latest awesome features from neovim core.
-- Telescope is centered around modularity, allowing for easy customization.

local function config()
  local actions = require("telescope.actions")
  require('telescope').setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
        }
      }
    }
  })

  local function hook()
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

  wk.register({
      ["gd"] = {
        "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",
        "TELE::LSP:: definition" },
      ["gr"] = {
        "<cmd>lua require('telescope.builtin').lsp_references()<cr>",
        "TELE::LSP:: reference" },
      ["gi"] = {
        "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>",
        "TELE::LSP:: implementation" },
      ["gy"] = {
        "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>",
        "TELE::LSP:: type definition" },
      ["<space>e"] = {
        "<cmd>lua require('telescope.builtin').diagnostics()<cr>",
        "TELE::LSP:: diagnostics" },
      ["<space>a"] = {
        "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>",
        "TELE::LSP:: code action" },
      ["<space>S"] = {
        "<cmd>lua require('telescope.builtin')."..
        "lsp_dynamic_workspace_symbols()<cr>",
        "TELE::LSP:: workspace symbol" },
    },
    key_opts
  )

  key_opts = {
    mode    = "n",
    buffer  = nil, -- Global
    silent  = true, -- use `silent ` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
  }

  wk.register(
    {
      ["<leader>E"] = {
        "<cmd>lua require('telescope.builtin').find_files()<cr>",
        "TELE:: search filename" },
      ["<leader>R"] = {
        "<cmd>lua require('telescope.builtin').live_grep()<cr>",
        "TELE:: search in files" },
      ["<leader>B"] = {
        "<cmd>lua require('telescope.builtin').buffers()<cr>",
        "TELE:: buffer list" },
      ["<leader>?"] = {
        "<cmd>lua require('telescope.builtin').help_tags()<cr>",
        "TELE:: helps" },
    },
    key_opts
  )
  end

  table.insert(Global_On_Attach_hooks, hook)
end

return {
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },
  config = config,
}
