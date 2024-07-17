-- https://github.com/nvim-telescope/telescope.nvim

-- Description:
-- telescope.nvim is a highly extendable fuzzy finder over lists.
-- Built on the latest awesome features from neovim core.
-- Telescope is centered around modularity, allowing for easy customization.

local builtin = "<cmd>lua require('telescope.builtin')."
local lsp_prefix = "TELE::LSP:: "
local function hook()
        require("which-key").add({
                {
                        "<space>H",
                        builtin .. "jumplist()<cr>",
                        buffer = 11,
                        desc = "TELE:: jump list",
                        remap = false
                },
                {
                        "<space>M",
                        builtin .. "marks()<cr>",
                        buffer = 11,
                        desc = "TELE:: mark list",
                        remap = false
                },
                {
                        "<space>s",
                        builtin .. "lsp_document_symbols()<cr>",
                        buffer = 11,
                        desc =
                        "TELE::LSP:: document symbol",
                        remap = false
                },
                {
                        "gd",
                        builtin .. "lsp_definitions()<cr>",
                        buffer = 11,
                        desc =
                        "TELE::LSP:: definition",
                        remap = false
                },
                {
                        "gi",
                        builtin .. "lsp_implementations()<cr>",
                        buffer = 11,
                        desc =
                        "TELE::LSP:: implementation",
                        remap = false
                },
                {
                        "gr",
                        builtin .. "lsp_references()<cr>",
                        buffer = 11,
                        desc =
                        "TELE::LSP:: reference",
                        remap = false
                },
                {
                        "gy",
                        builtin .. "lsp_type_definitions()<cr>",
                        buffer = 11,
                        desc =
                        "TELE::LSP:: type definition",
                        remap = false
                },
        })
end

table.insert(On_Attach_hooks, hook)


local function config()
        local actions = require("telescope.actions")
        require('telescope').setup({
                defaults = {
                        layout_strategy = "vertical",
                        layout_config = { vertical = { width = 0.9 } },
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
                },
                extensions = {
                        ["ui-select"] = {
                                require("telescope.themes").get_dropdown {} }
                }
        })

        require("telescope").load_extension("ui-select")
end

return {
        'nvim-telescope/telescope.nvim',
        dependencies = {
                'neovim/nvim-lspconfig',
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-ui-select.nvim',
        },
        keys = {
                {
                        "t?",
                        "<cmd>lua require('telescope.builtin').help_tags()<cr>",
                        desc = "TELE:: helps",
                        remap = false
                },
                {
                        "tR",
                        "<cmd>lua require('telescope.builtin').grep_string()<cr>",
                        desc = "TELE:: search in files",
                        remap = false
                },
                {
                        "tb",
                        "<cmd>lua require('telescope.builtin').buffers()<cr>",
                        desc = "TELE:: buffer list",
                        remap = false
                },
                {
                        "te",
                        "<cmd>lua require('telescope.builtin').find_files()<cr>",
                        desc = "TELE:: search filename",
                        remap = false
                },
                {
                        "tr",
                        "<cmd>lua require('telescope.builtin').live_grep()<cr>",
                        desc = "TELE:: search in files",
                        remap = false
                },
        },
        cmd = { 'Telescope' },
        config = config,
}
