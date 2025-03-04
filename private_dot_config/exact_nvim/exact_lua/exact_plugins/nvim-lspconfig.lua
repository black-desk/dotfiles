-- https://github.com/neovim/nvim-lspconfig

-- Description:
-- lsp configs for neovim builtin lsp

-- NOTE: In config() we are not allow to call other local functions, which
-- leads to a error. So we have to put all local functions at the start of
-- config()

local function config()
        local function get_my_lsp_configs()
                -- TODO: reduce duplicate code for read plugins config.
                local home = os.getenv('HOME')
                local lsp_configs = io.popen(
                        'find ' .. '"' ..
                        home .. '/.config/nvim/lua/lsp_configs/' ..
                        '"' .. ' -type f')
                local ret = {}
                if lsp_configs == nil then
                        return {}
                end
                for lsp_config in lsp_configs:lines() do
                        local name = string.match(
                                lsp_config,
                                home .. "/[.]config/nvim/lua/lsp_configs//?(.*)[.]lua")
                        if name ~= nil then
                                ret[name] = require("lsp_configs." .. name)
                        end
                end
                return ret
        end

        local function get_server_list()
                local server_map = {
                        bashls = 'bash-language-server',
                        clangd = 'clangd',
                        cmake = 'cmake-language-server',
                        eslint = 'vscode-eslint-language-server',
                        gopls = 'gopls',
                        hls = 'haskell-language-server',
                        efm = "efm-langserver",
                        jsonls = 'vscode-json-language-server',
                        lemminx = 'lemminx',
                        rime_ls = "rime_ls",
                        lua_ls = 'lua-language-server',
                        marksman = 'marksman',
                        perlnavigator = 'perlnavigator',
                        pyright = 'pyright',
                        rust_analyzer = 'rust-analyzer',
                        taplo = 'taplo',
                        texlab = 'texlab',
                        ts_ls = 'typescript-language-server',
                        tinymist = 'tinymist',
                        yamlls = 'yaml-language-server',
                }

                local server_list = {}

                for lsp, command in pairs(server_map) do
                        if vim.fn.executable(command) ~= 1 then
                                goto continue
                        end
                        table.insert(server_list, lsp)
                        ::continue::
                end

                return server_list
        end

        local lsp_config = get_my_lsp_configs()

        local configs = require('lspconfig.configs')
        if not configs.rime_ls then
                configs.rime_ls = {
                        default_config = {
                                name = "rime_ls",
                                cmd = { 'rime_ls' },
                                filetypes = { '*' },
                                single_file_support = true,
                        },
                }
        end

        local server_list = get_server_list()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
        }
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local default_lsp_config = {
                flags = { debounce_text_changes = nil },
                capabilities = capabilities
        }

        -- Use a loop to conveniently call 'setup' on multiple servers and map
        -- buffer local keybindings when the language server attaches.
        for _, lsp in ipairs(server_list) do
                local my_cfg = lsp_config[lsp]
                if my_cfg == nil then
                        my_cfg = {}
                end
                local cfg = vim.tbl_deep_extend(
                        'force', default_lsp_config, my_cfg)
                require('lspconfig')[lsp].setup(cfg)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                        local set_keymap = function(lhs, rhs, desc)
                                vim.keymap.set(
                                        "n", lhs, rhs,
                                        {
                                                buffer = args.buf,
                                                desc = desc
                                        }
                                )
                        end
                        set_keymap("K", vim.lsp.buf.hover, "do hover")
                        set_keymap("<C-k>", vim.lsp.buf.signature_help, "show signature help")
                        set_keymap("<space>rn", vim.lsp.buf.rename, "rename")
                        set_keymap("<space>f", function()
                                vim.lsp.buf.format({
                                        filter = function(client)
                                                return client.name ~= "tsserver"
                                        end
                                })
                        end, "format document")
                        set_keymap("<space>E", vim.diagnostic.open_float, "show float diagnostic")
                        set_keymap("<space>a", vim.lsp.buf.code_action, "show code action")

                        local client = vim.lsp.get_client_by_id(args.data.client_id)
                        if client == nil then
                                return
                        end

                        if client.name ~= "rime_ls" then
                                return
                        end

                        set_keymap("<leader><space>", function()
                                client.request("workspace/executeCommand", {
                                        command = "rime-ls.toggle-rime",
                                }, function(_, result, ctx, _)
                                        if ctx.client_id ~= client.id then
                                                return
                                        end
                                        vim.b.rime_enabled = result
                                        if result then
                                                vim.cmd([[:Copilot disable]])
                                        else
                                                vim.cmd([[:Copilot enable]])
                                        end
                                end)
                        end, "toggle rime")
                        set_keymap('<leader>rs', function()
                                client.request("workspace/executeCommand", {
                                        command = "rime-ls.sync-user-data",
                                })
                        end, "sync rime user data")
                end
        })
end

return {
        'neovim/nvim-lspconfig',
        config = config,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
                'kevinhwang91/nvim-ufo',
                'creativenull/efmls-configs-nvim',
        }
}
