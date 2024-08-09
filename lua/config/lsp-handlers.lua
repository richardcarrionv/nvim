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

M.on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

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
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references show_line=false<CR>", bufopts)

  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)

  vim.keymap.set("n", "<leader>na", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)

  vim.keymap.set("n", "<leader>ca", "<cmd>CodeActionMenu<CR>", bufopts)
end

return M
