-- https://github.com/kyazdani42/nvim-tree.lua

-- Description:
-- file explorer

local function config()
  vim.g.nvim_tree_quit_on_open = 1 -- 0 by default, closes the tree when you open a file
  vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
  vim.g.nvim_tree_git_hl = 0 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
  vim.g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
  vim.g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
  vim.g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
  vim.g.nvim_tree_group_empty = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
  vim.g.nvim_tree_disable_window_picker = 0 -- 0 by default, will disable the window picker.
  vim.g.nvim_tree_icon_padding = ' ' -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
  vim.g.nvim_tree_symlink_arrow = ' -> ' --  defaults to ' ➛ '. used as a separator between symlinks' source and target.
  vim.g.nvim_tree_respect_buf_cwd = 0 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
  vim.g.nvim_tree_create_in_closed_folder = 0 -- 1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
  vim.g.nvim_tree_refresh_wait = 500 -- 1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
  vim.g.nvim_tree_window_picker_exclude = {
    filetype ={
      'notify',
      'packer',
      'qf'
    },
    buftype={
      'terminal',
    }
  }
  vim.g.nvim_tree_icons = {
    default = '',
  }
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  local list = {
    { key = "l",     cb = tree_cb("edit") },
    { key = "L",     cb = tree_cb("cd") },
    { key = "h",     cb = tree_cb("close_node") },
    { key = "<Tab>", cb = tree_cb("preview") },
    { key = "K",     cb = tree_cb("first_sibling") },
    { key = "J",     cb = tree_cb("last_sibling") },
    { key = "H",     cb = tree_cb("toggle_dotfiles") },
    { key = "R",     cb = tree_cb("refresh") },
    { key = "a",     cb = tree_cb("create") },
    { key = "D",     cb = tree_cb("remove") },
    { key = "d",     cb = tree_cb("trash") },
    { key = "r",     cb = tree_cb("rename") },
    { key = "x",     cb = tree_cb("cut") },
    { key = "c",     cb = tree_cb("copy") },
    { key = "p",     cb = tree_cb("paste") },
    { key = "y",     cb = tree_cb("copy_name") },
    { key = "Y",     cb = tree_cb("copy_path") },
    { key = "<C-y>", cb = tree_cb("copy_absolute_path") },
    { key = "gk",    cb = tree_cb("prev_git_item") },
    { key = "gj",    cb = tree_cb("next_git_item") },
    { key = "..",     cb = tree_cb("dir_up") },
    { key = "s",     cb = tree_cb("system_open") },
    { key = "q",     cb = tree_cb("close") },
    { key = "g?",    cb = tree_cb("toggle_help") },
  }

  -- FIXME use lua here
  vim.cmd([[
    nnoremap <silent> <leader>e :NvimTreeToggle<CR>
  ]])

  require('nvim-tree').setup {
    disable_netrw       = false,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    auto_close          = false,
    open_on_tab         = false,
    hijack_cursor       = true,
    update_cwd          = true,
    update_to_buf_dir   = {
      enable = true,
      auto_open = true,
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      }
    },
    update_focused_file = {
      enable      = true,
      update_cwd  = true,
      ignore_list = {}
    },
    system_open = {
      cmd  = nil,
      args = {}
    },
    filters = {
      dotfiles = false,
      custom = {}
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = 'left',
      auto_resize = false,
      mappings = {
        custom_only = true,
        list = list,
      },
      number = false,
      relativenumber = false,
      signcolumn = "yes"
    },
    trash = {
      cmd = "trash",
      require_confirm = true
    }
  }
end

return {
  'kyazdani42/nvim-tree.lua',
  requires = {
    -- https://github.com/kyazdani42/nvim-web-devicons
    'kyazdani42/nvim-web-devicons', -- icon
  },
  config = config,
}
