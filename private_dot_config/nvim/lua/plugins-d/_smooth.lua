-- https://github.com/karb94/neoscroll.nvim

-- Description:
-- a smooth scrolling neovim plugin written in lua

local function config()
  require('neoscroll').setup()
end

return {
  'karb94/neoscroll.nvim',
  config = config,
}
