-- https://github.com/windwp/nvim-autopairs

-- Description:
-- Insert or delete brackets, parens, quotes in pair.

local function config()
  local opts = {}
  require('nvim-autopairs').setup(opts)
end

return {
  'windwp/nvim-autopairs',
  config = config,
}
