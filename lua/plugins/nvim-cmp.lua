return {
  "hrsh7th/nvim-cmp",
  config = function()
    require("plugins.lsp.nvim-cmp")
  end,
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
}
