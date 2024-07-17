-- https://github.com/nvim-telescope/telescope.nvim

-- Description:
-- telescope.nvim is a highly extendable fuzzy finder over lists.
-- Built on the latest awesome features from neovim core.
-- Telescope is centered around modularity, allowing for easy customization.

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

        local builtin = "<cmd>lua require('telescope.builtin')."
        local lsp_prefix = "TELE::LSP:: "

        local function hook()
                local wk = require("which-key")
                local key_opts = {
                        mode    = "n",
                        buffer  = 0,    -- local mappings
                        silent  = true, -- use `silent ` when creating keymaps
                        noremap = true, -- use `noremap` when creating keymaps
                }


                wk.register({
                        ["gd"] = {
                                builtin .. "lsp_definitions()<cr>",
                                lsp_prefix .. "definition" },
                        ["gr"] = {
                                builtin .. "lsp_references()<cr>",
                                lsp_prefix .. "reference" },
                        ["gi"] = {
                                builtin .. "lsp_implementations()<cr>",
                                lsp_prefix .. "implementation" },
                        ["gy"] = {
                                builtin .. "lsp_type_definitions()<cr>",
                                lsp_prefix .. "type definition" },
                        ["<space>s"] = {
                                builtin .. "lsp_document_symbols()<cr>",
                                lsp_prefix .. "document symbol" },
                        ["<space>H"] = {
                                builtin .. "jumplist()<cr>",
                                "TELE:: jump list" },
                        ["<space>M"] = {
                                builtin .. "marks()<cr>",
                                "TELE:: mark list" },
                }, key_opts)
        end

        table.insert(On_Attach_hooks, hook)

        local wk = require("which-key")

        wk.add({
                { "t?", "<cmd>lua require('telescope.builtin').help_tags()<cr>",   desc = "TELE:: helps",           remap = false },
                { "tR", "<cmd>lua require('telescope.builtin').grep_string()<cr>", desc = "TELE:: search in files", remap = false },
                { "tb", "<cmd>lua require('telescope.builtin').buffers()<cr>",     desc = "TELE:: buffer list",     remap = false },
                { "te", "<cmd>lua require('telescope.builtin').find_files()<cr>",  desc = "TELE:: search filename", remap = false },
                { "tr", "<cmd>lua require('telescope.builtin').live_grep()<cr>",   desc = "TELE:: search in files", remap = false },
        })

        require("telescope").load_extension("ui-select")
end

return {
        'nvim-telescope/telescope.nvim',
        dependencies = {
                'nvim-lspconfig',
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-ui-select.nvim',
        },
        config = config,
}
