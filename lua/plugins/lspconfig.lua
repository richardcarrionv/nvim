return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")


    local handlers = require("config.lsp-handlers")
    local servers = {
      "html",
      "cssls",
      "jsonls",
      "pyright",
      "ts_ls",
      "lua_ls",
      "texlab",
      "tailwindcss",
      "bashls",
      "gradle_ls"
      -- "kotlin_language_server"
    }

    local vim_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = cmp_nvim_lsp.default_capabilities(vim_capabilities)


    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = servers,
    })

    for _, server in pairs(servers) do
      local setup_options = {
        on_attach = handlers.on_attach,
        capabilities = capabilities,
      }

      if server == "ts_ls" then
        lspconfig[server].setup({
          on_attach = handlers.on_attach,
          capabilities = capabilities,
          init_options = {
            hostInfo = "neovim",
            preferences = {
              providePrefixAndSuffixTextForRename = false,
            },
          },
        })
      elseif server == "lua_ls" then
        lspconfig[server].setup({
          on_attach = handlers.on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      else
        lspconfig[server].setup(setup_options)
      end
    end

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
  end,
}
