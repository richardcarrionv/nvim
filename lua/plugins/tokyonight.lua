require("tokyonight").setup({
  -- use the night style
  style = "night",
  -- disable italic for functions
  -- styles = {
  --   functions = {}
  -- },
  -- sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  brightness = 0.1,
  terminal_colors = true,
  on_colors = function(colors)
    colors.bg = "#0a0a0a"
    colors.bg_sidebar = "#0f0f0f"
    colors.border = "#706f6e"
  end,
  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(hl, cl)
    hl.StatusLine = {
      bg = cl.blue7,
      fg = cl.blue,
    }
    hl.StatusLineNC = {
      bg = cl.bg,
      fg = "#a8aecb"
    }
    hl["@tag.tsx"] = {
      fg = cl.blue
    }
    hl.TabLineSel = {
      bg = "#301c4c",
      fg = "#bca3de"
    }
  end,
})

vim.cmd("colorscheme tokyonight-night")
--vim.cmd([[ autocmd VimEnter * colorscheme tokyonight-night ]])
