require("settings")
require("mappings")
require("plugins")

require("plugins.rose-pine")
require("plugins.uuid-plugin")

require("lazy-term").setup()

function find_buffer_by_name(buffer_name)
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(bufnr)
		if name ~= "" and vim.fn.fnamemodify(name, ":t") == buffer_name then
			return bufnr
		end
	end
	return nil
end

function run(opts)
	local output = vim.fn.system(opts.args)

	local bufnr = find_buffer_by_name("Result")
	local windid = vim.fn.win_findbuf(bufnr)[1]

	if windid ~= nil then
		vim.api.nvim_set_current_win(windid)
	else
		vim.api.nvim_command("vs Result")
		vim.api.nvim_command("setlocal bufhidden=hide")
		vim.api.nvim_command("setlocal buftype=nofile")
		vim.api.nvim_command("setlocal noswapfile")
		vim.api.nvim_command("setlocal filetype=txt")
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.split(output, "\n"))
end

vim.api.nvim_create_user_command("Run", run, { nargs = "*" })
