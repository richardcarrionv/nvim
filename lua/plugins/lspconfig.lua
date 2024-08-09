return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  config = function()
    require("plugins.lsp.lspconfig")
  end,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  }
}
