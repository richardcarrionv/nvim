local handlers = require('plugins.lsp.handlers')

local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')
--local cmp_nvim_lsp = require('cmp_nvim_lsp')


--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local servers = {
  "angularls",
  "html",
  "cssls",
  "jsonls",
  "jdtls",
  "intelephense",
  "pyright",
  "tsserver",
  "lua_ls",
  "texlab",
  "volar",
  "clangd",
  "tailwindcss",
}

mason.setup()
mason_lspconfig.setup({
  ensure_installed = servers
})


for _, server in pairs(servers) do
  local setup_options = {
    on_attach = handlers.on_attach,
    capabilities = capabilities
  }
  lspconfig[server].setup(setup_options)
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = true,
  severity_sort = false,
})

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
