require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- astro = { "rustywind" },
    astro = function(bufnr)
      vim.lsp.buf.format()
      return { "rustywind" }
    end,
    javascript = { "prettierd", "eslint_d" },
    javascriptreact = { "prettierd", "eslint_d" },
    typescriptreact = { "prettierd", "eslint_d" },
    typescript = { "prettierd", "eslint_d" },
    tex = { "latexindent" },
    java = { "google-java-format" },
    sql = { "sql_formatter" },
  },
})

vim.api.nvim_create_user_command("Conform", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
  -- require("lint").try_lint()
end, { range = true })

vim.api.nvim_create_user_command("OConform", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = false, range = range })
  -- require("lint").try_lint()
end, { range = true })
