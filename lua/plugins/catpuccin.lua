return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#0a0a0a",
          crust = "#0a0a0a",
        },
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme "catppuccin"
  end
}
