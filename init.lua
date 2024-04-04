require("settings")
require("mappings")
require("plugins")

require("plugins.rose-pine")
require("plugins.uuid-plugin")

require("plugins.dap")
require("dapui").setup()
require("plugins.harpoon")

function find_buffer_by_name(buffer_name)
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(bufnr)
		if name ~= "" and vim.fn.fnamemodify(name, ":t") == buffer_name then
			return bufnr
		end
	end
	return nil
end

function handle_note_title(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local title = table.concat(lines, " ")
	local md_title = "# " .. title
	local lower_title = string.lower(title)
	local filename = string.gsub(lower_title, "%s+", "_") .. ".md"

	vim.cmd("vs ~/Workspace/notes/" .. filename)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.split(md_title, "\n"))
	vim.cmd("write")
end

function open_note_title_win()
	local bufnr = find_buffer_by_name("NOTE TITLE")
	if bufnr == nil then
		bufnr = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(bufnr, "NOTE TITLE")
		vim.api.nvim_set_option_value("filetype", "txt", {
			buf = bufnr,
		})
	else
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
	end
	local winwidth = vim.fn.winwidth(0)
	local width = math.floor(vim.api.nvim_get_option("columns") * 0.6) -- 90% of the columns
	local height = 1

	-- Calculate the position for centering the window
	local row = math.floor((vim.api.nvim_get_option("lines") - height) / 2)
	local col = math.floor((vim.api.nvim_get_option("columns") - width) / 2)

	vim.api.nvim_open_win(bufnr, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		focusable = true,
		border = "rounded",
		title = "Note Title",
	})

	local fun = string.format("handle_note_title(%d)", bufnr)

	vim.api.nvim_buf_set_keymap(bufnr, "i", "<CR>", "<CMD>close | lua " .. fun .. "<CR>", { silent = true })

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<CR>", ":close | lua " .. fun .. "<CR>", { noremap = true, silent = true })
end
