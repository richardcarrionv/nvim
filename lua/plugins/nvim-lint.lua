require('lint').linters_by_ft = {
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
}


vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI"}, {
  callback = function()
    require("lint").try_lint()
  end,
})
