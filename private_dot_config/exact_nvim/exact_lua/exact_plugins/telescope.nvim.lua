-- https://github.com/nvim-telescope/telescope.nvim

-- Description:
-- telescope.nvim is a highly extendable fuzzy finder over lists.
-- Built on the latest awesome features from neovim core.
-- Telescope is centered around modularity, allowing for easy customization.

local builtin = "<cmd>lua require('telescope.builtin')."
local lsp_prefix = "TELE::LSP:: "
local function hook(_, bufnr)
        require("which-key").add({
                {
                        "<space>H",
                        builtin .. "jumplist()<cr>",
                        buffer = bufnr,
                        desc = "TELE:: jump list",
                        remap = false
                },
                {
                        "<space>M",
                        builtin .. "marks()<cr>",
                        buffer = bufnr,
                        desc = "TELE:: mark list",
                        remap = false
                },
                {
                        "<space>s",
                        builtin .. "lsp_document_symbols()<cr>",
                        buffer = bufnr,
                        desc =
                        "TELE::LSP:: document symbol",
                        remap = false
                },
                {
                        "gd",
                        builtin .. "lsp_definitions()<cr>",
                        buffer = bufnr,
                        desc =
                        "TELE::LSP:: definition",
                        remap = false
                },
                {
                        "gi",
                        builtin .. "lsp_implementations()<cr>",
                        buffer = bufnr,
                        desc =
                        "TELE::LSP:: implementation",
                        remap = false
                },
                {
                        "gr",
                        builtin .. "lsp_references()<cr>",
                        buffer = bufnr,
                        desc =
                        "TELE::LSP:: reference",
                        remap = false
                },
                {
                        "gy",
                        builtin .. "lsp_type_definitions()<cr>",
                        buffer = bufnr,
                        desc =
                        "TELE::LSP:: type definition",
                        remap = false
                },
        })
end

local function init()
        table.insert(On_Attach_hooks, hook)
end

local function config()
        local actions = require("telescope.actions")
        local fb_actions = require "telescope._extensions.file_browser.actions"
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
                                require("telescope.themes").get_dropdown {} },
                        file_browser = {
                                hijack_netrw = true,
                                mappings = {
                                        n = {
                                                l = actions.select_default,
                                                h = fb_actions.goto_parent_dir,
                                        }
                                }
                        },
                        project = {
                                base_dirs = { {
                                        "~/Documents/workspace/repos",
                                        max_depth = 3,
                                }
                                }
                        }
                }
        })

        require("telescope").load_extension("ui-select")
        require 'telescope'.load_extension('project')
        require 'telescope'.load_extension('file_browser')
end

local extensions = {
        {
                'nvim-telescope/telescope-ui-select.nvim',
                dependencies = { 'nvim-telescope/telescope.nvim' }
        },
        {
                'nvim-telescope/telescope-project.nvim',
                dependencies = { 'nvim-telescope/telescope.nvim' }
        },
        {
                'nvim-telescope/telescope-file-browser.nvim',
                dependencies = { 'nvim-telescope/telescope.nvim' }
        },
}

return { {
        'nvim-telescope/telescope.nvim',
        dependencies = {
                'nvim-lua/plenary.nvim',
        },
        keys = {
                {
                        "<leader>p",
                        function()
                                require('telescope').
                                    extensions.
                                    project.
                                    project({
                                            initial_mode = "normal"
                                    })
                        end,
                        desc = "TELE:: projects browser",
                        remap = false
                },
                {
                        "<leader>e",
                        function()
                                require('telescope').
                                    extensions.
                                    file_browser.
                                    file_browser({
                                            initial_mode = "normal"
                                    })
                        end,
                        desc = "TELE:: file browser",
                        remap = false
                },
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
        init = init,
        cmd = { 'Telescope' },
        config = config,
}, table.unpack(extensions) }
