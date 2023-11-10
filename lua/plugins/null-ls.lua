local null_ls = require("null-ls")
local methods = require("null-ls.methods")

local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

null_ls.setup({
  sources = {

    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.latexindent,
    null_ls.builtins.formatting.sql_formatter,
    null_ls.builtins.diagnostics.sqlfluff,



    -- null_ls.builtins.formatting.rustywind,
    -- null_ls.builtins.code_actions.eslint,


    null_ls.builtins.formatting.google_java_format,

    -- Python
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.isort,
  },
  on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "<leader>fm", function()
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
        async = true,
      })
    end, bufopts)


    vim.keymap.set("x", "<leader>fm", function()
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
        async = true,
      })
    end, bufopts)
  end,
})
