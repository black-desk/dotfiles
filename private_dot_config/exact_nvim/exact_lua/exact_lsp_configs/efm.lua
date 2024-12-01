-- Register linters and formatters per language
local prettierd = require('efmls-configs.formatters.prettier_d')
local black = require('efmls-configs.formatters.black')
-- local clang_tidy = require('efmls-configs.linters.clang_tidy')
local languages = {
        markdown = { prettierd },
        python = { black },
        -- c = { clang_tidy },
        -- cpp = { clang_tidy },
}

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require('efmls-configs.defaults').languages()

local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
                rootMarkers = { 'build/compile_commands.json', ".git" },
                languages = languages,
        },
        init_options = {
                documentFormatting = true,
                documentRangeFormatting = true,
        },
}

return efmls_config
