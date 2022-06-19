-- https://github.com/neovim/nvim-lspconfig

-- Description:
-- lsp configs for neovim builtin lsp

Capabilities = vim.lsp.protocol.make_client_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
On_Attach_hooks = {}
function On_Attach(client, bufnr)
        local wk = require("which-key")
        local key_opts = {
                mode    = "n",
                buffer  = 0, -- local mappings
                silent  = true, -- use `silent ` when creating keymaps
                noremap = true, -- use `noremap` when creating keymaps
        }

        wk.register({
                ["K"] = {
                        "<cmd>lua vim.lsp.buf.hover()<CR>",
                        "LSP:: hover" },
                ["<C-k>"] = {
                        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                        "LSP:: signature help" },
                ["<space>rn"] = {
                        "<cmd>lua vim.lsp.buf.rename()<CR>",
                        "LSP:: rename" },
                ["<space>f"] = {
                        "<cmd>lua vim.lsp.buf.formatting()<CR>",
                        "LSP:: format" },
                ["<space>E"] = {
                        "<cmd>lua vim.diagnostic.open_float()<CR>",
                        "LSP:: float diagnostic" },
                ["<space>a"] = {
                        "<cmd>lua vim.lsp.buf.code_action()<CR>",
                        "LSP:: code action" },
        }, key_opts)

        key_opts = {
                mode    = "n",
                buffer  = 0, -- local mappings
                silent  = true, -- use `silent ` when creating keymaps
                noremap = false, -- not use `noremap` when creating keymaps
        }

        wk.register({
                ["gd"] = {
                        "<cmd>lua vim.lsp.buf.definition()<cr>",
                        "LSP:: definition" },
                ["gr"] = {
                        "<cmd>lua vim.lsp.buf.references()<cr>",
                        "LSP:: reference" },
                ["gi"] = {
                        "<cmd>lua vim.lsp.buf.implementation()<cr>",
                        "LSP:: implementation" },
                ["gy"] = {
                        "<cmd>lua vim.lsp.buf.type_definition()<cr>",
                        "LSP:: type definition" },
                ["<leader>t"] = {
                        "<cmd>AerialToggle<cr>",
                        "LSP:: show outline" },
        }, key_opts)

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
                        local part1, part2 = string.match(
                                lsp_config,
                                home .. "/[.]config/nvim/lua/(.*)_(.*)[.]lua")
                        if part1 ~= nil and part2 ~= nil then
                                lsp_config = part1 .. '_' .. part2
                                ret[part2] = require(lsp_config)
                        end
                end
                return ret
        end

        local lsp_config = get_my_lsp_configs()

        local server_list = {
                'bashls',
                'clangd',
                'gopls',
                'jsonls',
                'pyright',
                'tsserver',
                'texlab',
        }

        require("nvim-lsp-installer").setup({
                ensure_installed = server_list,
                -- NOTE: this `automatic_installation` means automatically
                -- detect which servers to install (based on which servers are
                -- set up via lspconfig), but I do not want this.
                automatic_installation = false,
        })

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
                        'force',
                        default_lsp_config, my_cfg)
                require('lspconfig')[lsp].setup(cfg)
        end

        require("aerial").setup()
end

return {
        'black-desk/nvim-lspconfig',
        config = config,
        after = {
                'nvim-cmp',
        },
        requires = {
                'williamboman/nvim-lsp-installer',
                'stevearc/aerial.nvim',
        }
}
