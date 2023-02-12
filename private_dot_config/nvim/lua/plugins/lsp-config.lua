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
                        "LSP:: hover"
                },
                ["<C-k>"] = {
                        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                        "LSP:: signature help"
                },
                ["<space>rn"] = {
                        "<cmd>lua vim.lsp.buf.rename()<CR>",
                        "LSP:: rename"
                },
                ["<space>f"] = {
                        "<cmd>lua vim.lsp.buf.format( {filter = function(client) return client.name ~= \"clangd\" end})<CR>",
                        "LSP:: format"
                },
                ["<space>E"] = {
                        "<cmd>lua vim.diagnostic.open_float()<CR>",
                        "LSP:: float diagnostic"
                },
                ["<space>a"] = {
                        "<cmd>lua vim.lsp.buf.code_action()<CR>",
                        "LSP:: code action"
                },
        }, key_opts)

        key_opts = {
                mode    = "n",
                buffer  = 0, -- local mappings
                silent  = true, -- use `silent ` when creating keymaps
                noremap = false, -- not use `noremap` when creating keymaps
        }

        wk.register({
                ["<leader>t"] = {
                        "<cmd>AerialToggle<cr>",
                        "LSP:: show outline"
                },
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
                'cmake',
                'eslint',
                'gopls',
                'hls',
                'jsonls',
                'pyright',
                'rust_analyzer',
                'sumneko_lua',
                'texlab',
                'tsserver',
        }

        require("mason").setup()

        require("mason-lspconfig").setup({
                automatic_installation = true,
        })

        -- my own lsp config

        -- NOTE: This only work if `table.unpack` is the last argument.
        -- https://stackoverflow.com/questions/1410862/concatenation-of-tables-in-lua#comment123687523_54352037
        -- https://stackoverflow.com/questions/37372182/what-is-happening-when-i-call-unpack-as-luas-function-arguments
        table.insert(server_list, 1, "mdlsp")

        require("lspconfig.configs")["mdlsp"] = {
                default_config = {
                        cmd = { 'mdlsp' },
                        filetypes = { 'markdown' },
                        root_dir = require('lspconfig.util').find_git_ancestor,
                        single_file_support = true,
                },
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

        require("aerial").setup()


        local h = require("null-ls.helpers")
        local methods = require("null-ls.methods")

        local FORMATTING = methods.internal.FORMATTING


        local get_lines = function(diff)
                local lines = {}
                for begin, length in string.gmatch(diff, '@@ [^+]++(%d+),?([^ @]*) @@') do
                        if #length ==0 then
                                length = 0
                        end
                        table.insert(lines, "--lines=" .. begin .. ":" .. begin + length)
                end
                return lines
        end

        require("null-ls").setup({
                debug = true,
                on_init = function(new_client, _)
                        new_client.offset_encoding = 'utf-8'
                end,
                on_attach = On_Attach,
                sources = {
                        require("null-ls").builtins.formatting.shfmt,
                        h.make_builtin({
                                name = "git_clang_format",
                                meta = {
                                        description = "Invoke clang-format on the changes in current files or a specific commit",
                                },
                                method = { FORMATTING },
                                filetypes = { "c", "cpp", "cs", "java", "cuda" },
                                generator_opts = {
                                        command = "clang-format",
                                        args = function(params)
                                                local tempfile = vim.fn.tempname()
                                                local git_repo_root = vim.fn.system("git rev-parse --show-toplevel")
                                                local filepath = params.bufname:sub(#git_repo_root + 1)
                                                local head_content = vim.fn.systemlist("git show HEAD:" .. filepath)
                                                vim.fn.writefile(head_content, tempfile)
                                                local diff = vim.fn.system(
                                                        { "git", "diff", "-U0", "--no-index", "--", tempfile, "-" },
                                                        params.content
                                                )
                                                vim.fn.delete(tempfile)
                                                local lines = get_lines(diff)
                                                return { "--assume-filename", "$FILENAME", unpack(lines) }
                                        end,
                                        to_stdin = true,
                                },
                                factory = h.formatter_factory,
                        }),
                        require("null-ls").builtins.formatting.golines.with({
                                extra_args = {
                                        "-m", "80", "-t", "8",
                                        -- "--shorten-comments",
                                        -- comment as golines will shorten comment inside raw string
                                }
                        }),
                        require("null-ls").builtins.diagnostics.golangci_lint,
                }
        })
end

return {
        'neovim/nvim-lspconfig',
        config = config,
        dependencies = {
                'folke/neodev.nvim',
                'folke/which-key.nvim',
                'jose-elias-alvarez/null-ls.nvim',
                'kevinhwang91/nvim-ufo',
                'stevearc/aerial.nvim',
                'williamboman/mason-lspconfig.nvim',
                'williamboman/mason.nvim',
        }
}
