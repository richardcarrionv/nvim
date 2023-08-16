local telescope = require('telescope')
local telescope_ignore = require('plugins.telescope-ignore')
telescope.setup {
  defaults = {
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s (%s)", tail, path)
    end,
    file_ignore_patterns = telescope_ignore.ignored_files,
    mappings = {
      i = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-l>"] = "send_selected_to_loclist",
        ["<C-h>"] = "select_horizontal",
        ["<C-v>"] = "select_vertical",

        ["<leader>q"] = "close",
        ["<leader>v"] = "select_vertical",
        ["<leader>h"] = "select_horizontal",
        ["<leader>t"] = "select_tab",
      },
      n = {
        ["k"] = "move_selection_previous",
        ["j"] = "move_selection_next",
        ["l"] = "send_selected_to_loclist",
        ["<leader>q"] = "close",
        ["q"] = "close",

        ["v"] = "select_vertical",
        ["h"] = "select_horizontal",

        ["t"] = "select_tab",
      }
    },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },

  },
  pickers = {
    buffers = {
      initial_mode = "normal",
      theme = "dropdown",
      previewer = false,
      sorting_strategy = "ascending",
    },

    lsp_references = {
      theme = "dropdown",
      initial_mode = "normal",
      show_line = false,
    },

    lsp_definitions = {
      theme = "dropdown",
      initial_mode = "normal",
    },

    lsp_declarations = {
      theme = "dropdown",
      initial_mode = "normal",
    },

    lsp_implementations = {
      theme = "dropdown",
      initial_mode = "normal",
    },
    oldfiles = {
      initial_mode = "normal",
      cwd_only=true
    },
  },
  extensions = {
    project = {
      order_by = "recent",
      sync_with_nvim_tree = false,
      display_type = "minimal"
    },
    file_browser = {
      initial_mode = "normal",
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      path_display = function(opts, path)
        local tail = require("telescope.utils").path_tail(path)
        return string.format("%s", tail)
      end,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  }
}
require("telescope").load_extension "file_browser"
require("telescope").load_extension("neoclip")
