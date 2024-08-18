-- https://github.com/neovim/nvim-lspconfig

-- Description:
-- lsp configs for neovim builtin lsp

Capabilities = vim.lsp.protocol.make_client_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
On_Attach_hooks = {}
function On_Attach(client, bufnr)
        local set_keymap = function(lhs, rhs, desc)
                local desc_prefix = "[lsp] "
                vim.keymap.set(
                        "n", lhs, rhs,
                        { ["desc"] = desc_prefix .. desc }
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

        for _, hook in ipairs(On_Attach_hooks) do
                if hook ~= nil then
                        hook(client, bufnr)
                end
        end
end

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
                                home .. "/[.]config/nvim/lua/lsp_configs/(.*)[.]lua")
                        if name ~= nil then
                                ret[name] = require("lsp_configs." .. name)
                        end
                end
                return ret
        end

        local lsp_config = get_my_lsp_configs()

        local server_list = {
                'bashls',
                'clangd',
                'cmake',
                'efm',
                'eslint',
                'gopls',
                'lemminx',
                'taplo',
                -- 'hls',
                'perlnavigator',
                'typst_lsp',
                'marksman',
                'jsonls',
                'pyright',
                'rust_analyzer',
                'lua_ls',
                'texlab',
                'tsserver',
        }

        local default_lsp_config = {
                flags = {
                        debounce_text_changes = nil,
                },
                on_attach = On_Attach,
                capabilities = Capabilities
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
end

return {
        'neovim/nvim-lspconfig',
        config = config,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
                'williamboman/mason.nvim',
        }
}
