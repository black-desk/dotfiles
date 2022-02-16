-- https://github.com/folke/todo-comments.nvim

-- Description:
-- todo-comments is a lua plugin for Neovim 0.5 to highlight and search for todo comments like TODO, HACK, BUG in your code base.

local function config()
  require("todo-comments").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    highlight = {
      keyword  = "bg",
      pattern = [[.*<(KEYWORDS)(\(.*\))?:]]
    },
    search = {
      pattern = [[\b(KEYWORDS)(\(.*\))?:]]
    }
  }
end

return {
  'folke/todo-comments.nvim',
  requires = "nvim-lua/plenary.nvim",
  config = config,
}
