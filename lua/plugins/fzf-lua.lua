require('fzf-lua').setup({
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F1>"]     = "toggle-help",
      ["<F2>"]     = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]     = "toggle-preview-wrap",
      ["<F4>"]     = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]     = "toggle-preview-ccw",
      ["<F6>"]     = "toggle-preview-cw",
      ["<C-d>"]   = "preview-page-down",
      ["<C-u>"]     = "preview-page-up",
      ["<S-left>"] = "preview-page-reset",
    },
  }
})
