require("settings")
require("mappings")
require("plugins")

require("plugins.rose-pine")
require("plugins.uuid-plugin")

local function find_buffer_by_name(buffer_name)
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(bufnr)
		if name ~= "" and vim.fn.fnamemodify(name, ":t") == buffer_name then
			return bufnr
		end
	end
	return nil
end

local function show_response(response, filetype)
	local bufnr = find_buffer_by_name("Response")
	local windid = vim.fn.win_findbuf(bufnr)[1]

	if windid ~= nil then
		vim.api.nvim_set_current_win(windid)
	else
		vim.api.nvim_command("split Response | setlocal bufhidden=hide | setlocal buftype=nofile | setlocal noswapfile")
	end

	if filetype ~= nil then
		vim.api.nvim_command("setlocal filetype=" .. filetype)
	else
		vim.api.nvim_command("setlocal filetype=txt")
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.split(response, "\n"))
end

local function system_command(cmd)
	local handle = io.popen(cmd .. " 2>/dev/null")
	local response = handle:read("*all")
	local _, exit_status, _ = handle:close()
	return response
end

local function get_lines_as_single_line(opts)
	local lines = nil
	if opts.count ~= -1 then
		lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
	else
		lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	end
	return table.concat(lines, " "):gsub("%s+", " ")
end

local function execute_stdin_command(opts)
	local line = get_lines_as_single_line(opts)

	local cmd = string.gsub(opts.args, "{{in}}", line)

	local response = system_command(cmd)

	show_response(response, filetype)
end

local function execute_command(opts)
	local filetype = opts.fargs[1]

  local cmd = get_lines_as_single_line(opts)
	local response = system_command(cmd)

	show_response(response, filetype)
end

local function open_concaterm(opts)
  local filetype = opts.fargs[1]
	local bufnr = find_buffer_by_name("ConcaDraft")
	local windid = vim.fn.win_findbuf(bufnr)[1]
	if windid ~= nil then
		vim.api.nvim_set_current_win(windid)
	else
		vim.api.nvim_command(
			"vs ConcaDraft | setlocal bufhidden=hide | setlocal buftype=nofile | setlocal noswapfile | setlocal filetype=bash"
		)
	end

end

vim.api.nvim_create_user_command("ConcaTermExecute", execute_command, { range = true, nargs = "*" })
vim.api.nvim_create_user_command("ConcaTermOpen", open_concaterm, { range = true, nargs = "*" })
vim.api.nvim_create_user_command("ConcaTermStdin", execute_stdin_command, { range = true, nargs = "*" })
