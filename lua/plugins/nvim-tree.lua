local mappings = require('plugins.misc.nvim-tree-mappings')

require("nvim-tree").setup({
  on_attach = mappings.on_attach,
  hijack_cursor = true,
  sort = {
    sorter = 'extension',
  },
  sync_root_with_cwd = true,
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
  filters = {
    custom = {
      '.aux',
      '.fdb_latexmk ',
      '.fls ',
      '.synctex.gz ',
      '__init__.py',
      '.null-ls'
    }
  },
  renderer = {
    indent_width = 2,
    root_folder_label = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  view = {
    width = 35,
    signcolumn = "yes",
  },
})

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not directory and not no_name then
    return
  end


  if directory then
    -- change to the directory
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
