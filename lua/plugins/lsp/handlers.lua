-- Handlers
M = {}

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local format_file = function()
  -- Get clients
  local clients = vim.lsp.get_active_clients({
    bufnr = vim.api.nvim_get_current_buf(),
  })

  local is_null_ls = false

  for _, client in ipairs(clients) do
    if client.name == "null-ls" and client.server_capabilities.documentFormattingProvider then
      is_null_ls = true
    end

  end

  if is_null_ls then

    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
      async = true,
    })

  else

    vim.lsp.buf.format()

  end
end

M.on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.keymap.set("n", "gD", "<cmd>Telescope lsp_declarations<CR>", bufopts)
  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
  vim.keymap.set("n", "<leader>vd", "<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set("n", "<leader>id", "<cmd>split<CR><cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set("n", "<leader>td", "<cmd>tab split<CR><cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)

  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)

  vim.keymap.set("n", "<leader>na", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)

  vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)

  vim.keymap.set("n", "<leader>fm", function()
    format_file()
  end, bufopts)

end

return M
