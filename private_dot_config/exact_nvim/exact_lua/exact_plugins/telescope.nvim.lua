-- https://github.com/nvim-telescope/telescope.nvim

-- Description:
-- telescope.nvim is a highly extendable fuzzy finder over lists.
-- Built on the latest awesome features from neovim core.
-- Telescope is centered around modularity, allowing for easy customization.

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
                                depth = false,
                                hidden = {
                                        file_browser = true,
                                        folder_browser = true,
                                },
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
                                        os.getenv("HOME") .. "/Documents/workspace/repos",
                                        max_depth = 3,
                                }
                                }
                        }
                }
        })

        require("telescope").load_extension("ui-select")
        require("telescope").load_extension('project')
        require("telescope").load_extension('file_browser')

        vim.api.nvim_create_autocmd("LspAttach", {
                callback = function()
                        local map = function(lhs, rhs, desc)
                                vim.keymap.set('n', lhs, rhs, {
                                        silent = true,
                                        buffer = true,
                                        desc = desc,
                                })
                        end

                        local builtin = require('telescope.builtin')

                        map("<space>H", builtin.jumplist, "Telescope jumplist")
                        map("<space>M", builtin.marks, "Telescope marks")
                        map("<space>s", builtin.lsp_document_symbols, "Telescope LSP document symbols")
                        map("gd", builtin.lsp_definitions, "Telescope LSP definitions")
                        map("gi", builtin.lsp_implementations, "Telescope LSP implementations")
                        map("gr", builtin.lsp_references, "Telescope LSP references")
                        map("gy", builtin.lsp_type_definitions, "Telescope LSP type definitions")
                end,
        })
end

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
                        desc = "Telescope projects browser",
                        remap = false
                },
                {
                        "<leader>e",
                        function()
                                require('telescope').
                                    extensions.
                                    file_browser.
                                    file_browser()
                        end,
                        desc = "Telescope file browser",
                        remap = false
                },
                {
                        "tR",
                        require('telescope.builtin').grep_string,
                        desc = "TELE:: search in files",
                        remap = false

                },
                {
                        "tr",
                        require('telescope.builtin').live_grep,
                        desc = "TELE:: search in files",
                        remap = false

                },
        },
        cmd = { 'Telescope' },
        event = "LspAttach",
        config = config,
},
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
