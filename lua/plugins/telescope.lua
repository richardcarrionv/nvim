local telescope = require('telescope')
local telescope_ignore = require('plugins.telescope-ignore')
telescope.setup {
  defaults = {
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s [%s]", tail, path)
    end,
    file_ignore_patterns = telescope_ignore.ignored_files,
    mappings = {
      i = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-l>"] = "send_selected_to_loclist",
        ["<C-h>"] = "select_horizontal",
        ["<C-v>"] = "select_vertical",
        ["<C-]>"] = "close",

        -- ["<leader>q"] = "close",
        -- ["<leader>v"] = "select_vertical",
        -- ["<leader>h"] = "select_horizontal",
        -- ["<leader>t"] = "select_tab",
      },
      n = {
        ["k"] = "move_selection_previous",
        ["j"] = "move_selection_next",
        ["l"] = "send_selected_to_loclist",
        ["<leader>q"] = "close",
        ["q"] = "close",

        -- ["v"] = "select_vertical",
        -- ["h"] = "select_horizontal",

        ["t"] = "select_tab",
      }
    },
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
      prompt_position = "top",
    }
  },
  pickers = {
    resume = {
      initial_mode = "normal",
    },
    live_grep = {
      previewer = false,
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
        height = 0.8,
        width = 0.8,
        preview_width = 0.7,
      },
      path_display = function(opts, path)
        local tail = require("telescope.utils").path_tail(path)
        return string.format("%s", tail)
      end,
    },
    buffers = {
      initial_mode = "normal",
      theme = "dropdown",
      previewer = false,
      sorting_strategy = "ascending",
    },

    lsp_references = {
      -- theme = "dropdown",
      initial_mode = "normal",
      show_line = true,
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
      cwd_only = true
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
    bibtex = {
      -- Depth for the *.bib file
      depth = 10,
      -- Custom format for citation label
      custom_formats = {},
      -- Format to use for citation label.
      -- Try to match the filetype by default, or use 'plain'
      format = '',
      -- Path to global bibliographies (placed outside of the project)
      global_files = {},
      -- Define the search keys to use in the picker
      search_keys = { 'author', 'year', 'title' },
      -- Template for the formatted citation
      citation_format = '{{author}} ({{year}}), {{title}}.',
      -- Only use initials for the authors first name
      citation_trim_firstname = true,
      -- Max number of authors to write in the formatted citation
      -- following authors will be replaced by "et al."
      citation_max_auth = 2,
      -- Context awareness disabled by default
      context = false,
      -- Fallback to global/directory .bib files if context not found
      -- This setting has no effect if context = false
      context_fallback = true,
      -- Wrapping in the preview window is disabled by default
      wrap = false,
    },
  }
}
require("telescope").load_extension("neoclip")
require "telescope".load_extension("bibtex")
