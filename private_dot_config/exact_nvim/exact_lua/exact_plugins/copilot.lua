return { {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
                require("copilot").setup({
                        panel = {
                                auto_refresh = true,
                        },
                        filetypes = {
                                go = true,
                                lua = true,
                                cpp = true,
                                cmake = true,
                        }
                })
        end,
        dependencies = {
                {
                        "zbirenbaum/copilot-cmp",
                        config = function()
                                require("copilot_cmp").setup()
                        end

                },
                -- {
                -- "CopilotC-Nvim/CopilotChat.nvim",
                -- branch = "canary",
                -- opts = {
                -- context = 'buffers'
                -- }
                -- }
        }

}, {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
}, {

        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
                provider = "copilot",
                sidebar_header = {
                        rounded = false,
                }
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
                "stevearc/dressing.nvim",
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
                --- The below dependencies are optional,
                "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
                "zbirenbaum/copilot.lua",      -- for providers='copilot'
                {
                        -- support for image pasting
                        "HakonHarnes/img-clip.nvim",
                        event = "VeryLazy",
                        opts = {
                                -- recommended settings
                                default = {
                                        embed_image_as_base64 = false,
                                        prompt_for_file_name = false,
                                        drag_and_drop = {
                                                insert_mode = true,
                                        },
                                        -- required for Windows users
                                        use_absolute_path = true,
                                },
                        },
                },
        },
} }
