-- https://github.com/nvim-telescope/telescope.nvim

-- Description:
-- telescope.nvim is a highly extendable fuzzy finder over lists.
-- Built on the latest awesome features from neovim core.
-- Telescope is centered around modularity, allowing for easy customization.

local function config()
        local actions = require("telescope.actions")
        require('telescope').setup({
                defaults = { mappings = {
                        i = {
                                ["<C-j>"] = actions.move_selection_next,
                                ["<C-k>"] = actions.move_selection_previous, },
                        n = {
                                ["<C-j>"] = actions.cycle_history_next,
                                ["<C-k>"] = actions.cycle_history_prev, } } },
                extensions = { ["ui-select"] = {
                        require("telescope.themes").get_dropdown {} } } })

        local builtin = "<cmd>lua require('telescope.builtin')."
        local lsp_prefix = "TELE::LSP:: "

        local function hook()
                local wk = require("which-key")
                local key_opts = {
                        mode    = "n",
                        buffer  = 0, -- local mappings
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
                        ["<space>e"] = {
                                builtin .. "diagnostics()<cr>",
                                lsp_prefix .. "diagnostics" },
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
        local key_opts = {
                mode    = "n",
                buffer  = nil, -- Global
                silent  = true, -- use `silent ` when creating keymaps
                noremap = true, -- use `noremap` when creating keymaps
        }

        wk.register({
                ["te"] = {
                        builtin .. "find_files()<cr>",
                        "TELE:: search filename" },
                ["tr"] = {
                        builtin .. "live_grep()<cr>",
                        "TELE:: search in files" },
                ["tR"] = {
                        builtin .. "grep_string()<cr>",
                        "TELE:: search in files" },
                ["tb"] = {
                        builtin .. "buffers()<cr>",
                        "TELE:: buffer list" },
                ["t?"] = {
                        builtin .. "help_tags()<cr>",
                        "TELE:: helps" },
        }, key_opts)

        require("telescope").load_extension("ui-select")
end

return {
        'nvim-telescope/telescope.nvim',
        requires = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-ui-select.nvim',
        },
        after = {
                'nvim-lspconfig',
        },
        config = config,
}
