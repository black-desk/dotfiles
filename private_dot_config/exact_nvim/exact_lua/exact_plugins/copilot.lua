return {
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
        }

}
