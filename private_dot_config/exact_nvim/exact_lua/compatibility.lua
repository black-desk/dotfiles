-- Some compatibility setup.

-- > Function unpack was moved into the table library and therefore must be called as table.unpack. 
-- Reference: https://www.lua.org/manual/5.2/manual.html
table.unpack = table.unpack or unpack -- NOLINT

-- > Remove at Nvim 1.0
-- > @deprecated
-- > vim.loop = vim.uv
-- Reference: https://github.com/neovim/neovim/blob/410cf29ee6a5d41a90d71d4d6d1fc84b5fe503e5/runtime/lua/vim/_editor.lua#L1127-L1129
vim.uv = vim.uv or vim.loop -- NOLINT
