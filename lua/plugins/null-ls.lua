local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.diagnostics.pylint.with({
    --   diagnostics_postprocess = function(diagnostic)
    --     diagnostic.code = diagnostic.message_id
    --   end,
    -- }),
    -- null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
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
  end,
})
