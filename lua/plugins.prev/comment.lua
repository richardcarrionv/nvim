return {
  "numToStr/Comment.nvim",
  event = "BufRead",
  config = function()
    require('Comment').setup({
      pre_hook =
          require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      opleader = {
        line = '<leader>c<leader>',
        block = '<leader>d<leader>',
      },
      padding = true,
    })
  end,
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter"
  },
}
