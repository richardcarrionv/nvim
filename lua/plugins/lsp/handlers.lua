-- Handlers
M = {}

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.filename, 'react/index.d.ts') == nil
end

local function on_list(options)
  local items = options.items
  if #items > 1 then
    items = filter(items, filterReactDTS)
  end

  vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
  vim.api.nvim_command('cfirst') -- or maybe you want 'copen' instead of 'cfirst'
end

local function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
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
  vim.keymap.set("n", "<leader>vd", function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition { on_list = on_list }
  end, bufopts)
  vim.keymap.set("n", "<leader>id", function()
    vim.cmd("split")
    vim.lsp.buf.definition { on_list = on_list }
  end, bufopts)
  vim.keymap.set("n", "<leader>td", function()
    vim.cmd("tab split")
    vim.lsp.buf.definition { on_list = on_list }
  end, bufopts)
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
