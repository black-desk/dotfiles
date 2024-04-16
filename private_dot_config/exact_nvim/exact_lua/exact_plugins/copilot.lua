return {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
                require("copilot").setup({
                        panel = {
                                auto_refresh = true,
                        },
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
