local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"

local lsp = {}

local function startsWithImport(str)
  return string.sub(str, 1, 6) == "import"
end

lsp.references = function(opts)
  local filepath = vim.api.nvim_buf_get_name(0)
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local params = vim.lsp.util.make_position_params(0)
  local include_current_line = vim.F.if_nil(opts.include_current_line, false)
  local include_imports = vim.F.if_nil(opts.include_imports, true)
  params.context = { includeDeclaration = vim.F.if_nil(opts.include_declaration, true) }

  vim.lsp.buf_request(opts.bufnr, "textDocument/references", params, function(err, result, ctx, _)
    if err then
      vim.api.nvim_err_writeln("Error when finding references: " .. err.message)
      return
    end

    local locations = {}
    if result then
      local results = vim.lsp.util.locations_to_items(result, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
      -- vim.print(results)
      if include_current_line then
        locations = vim.tbl_filter(function(v)
          -- Remove current line from result
          return not (v.filename == filepath and v.lnum == lnum)
        end, vim.F.if_nil(results, {}))
      else
        if include_imports then
          locations = vim.F.if_nil(results, {})
        else
          locations = vim.tbl_filter(function(v)
            return not (startsWithImport(v.text))
          end, vim.F.if_nil(results, {}))
        end
      end
    end

    if vim.tbl_isempty(locations) then
      return
    end

    pickers
        .new(vim.tbl_extend("keep", opts, {
          initial_mode = "normal",
        }), {
          prompt_title = "LSP References",
          finder = finders.new_table {
            results = locations,
            entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
          },
          previewer = conf.qflist_previewer(opts),
          sorter = conf.generic_sorter(opts),
          push_cursor_on_edit = true,
          push_tagstack_on_edit = true,
        })
        :find()
  end)
end

return lsp
