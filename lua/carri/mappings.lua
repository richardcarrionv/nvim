P = {}

local function command(action)
	return ":" .. action .. " <CR>"
end

local terminal = ""
local config_path = "~/.config/nvim/"
local isWindows = vim.fn.has("win32")

if not isWindows then
	terminal = "powershell.exe"
	config_path = "~/AppData/Local/nvim/"
end

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")

P.terminal = {
	none = {
		["<Esc>"] = "<C-\\><C-n>",
	},
}

P.normal = {
	none = {
		n = "nzzzv",
		N = "Nzzzv",
		["<C-d>"] = "<C-d>zz",
		["<C-u>"] = "<C-u>zz",
	},
	leader = {
		["<Enter>"] = "o<Esc>",
		[">"] = "10<C-w>>",
		["<"] = "10<C-w><",
		["+"] = "10<C-w>+",
		["-"] = "10<C-w>-",
		--A
		--B
		bd = command("bd!"),
		--C
		ck = command("lprevious"),
		cj = command("lnext"),
		-- ca = {code action}
		co = command("tabnew | tcd " .. config_path .. " | edit lua/plugins.lua  | vsplit init.lua "),
		--D
		df = command("Gitsign diffthis"),
		-- di = command("Trouble document_diagnostics"),
		--E
		-- es = command("EslintFixAll"),
		--F
		fl = command("Telescope find_files"),
		ff = command("Telescope buffers"),
		fm = command("Conform"),
		--G
		gp = command("Telescope live_grep "),
		--H
		h = command("tabprevious"),
		--I
		--J
		--K
		-- k = {signature help}
		--L
		l = command("tabnext"),
		--M
		ma = command("Telescope marks"),
		mt = "<C-w>T",
		ml = "<C-w>L",
		mh = "<C-w>H",
		mk = "<C-w>K",
		mj = "<C-w>J",
		--N
		nc = command("Gitsigns next_hunk"),
		nd = vim.diagnostic.goto_next,
		nf = command("NvimTreeFindFile"),
		--O
		ol = command("lopen"),
		--P
		--pd = { execute = vim.diagnostic.goto_prev },
		pd = command("Gitsigns preview_hunk"),
		--Q
		q = command("quit"),
		--R
		rf = command("Telescope oldfiles"),
		-- rn = {rename}
		--S
		sd = command("lua vim.diagnostic.open_float({focusable = true, focus=true})"),
		so = command("write | source"),
		--T
		tc = command("tabclose"),
		tn = command("tabnew"),
		tt = command("tabnew | terminal " .. terminal) .. "i",
		ts = command("vsplit | terminal " .. terminal) .. "i",
		ti = command("split | terminal " .. terminal) .. "i",
		--U
		--V
		vs = command("source $MYVIMRC"),
		--W
		w = command("write"),
		--Y
		--Z
		-- Symbols
	},
	control = {
		h = command("TmuxNavigateLeft"),
		j = command("TmuxNavigateDown"),
		k = command("TmuxNavigateUp"),
		l = command("TmuxNavigateRight"),
		n = command("NvimTreeToggle"),
	},
}

local make_keymap = {
	none = function(key)
		return key
	end,
	leader = function(key)
		return "<leader>" .. key
	end,
	control = function(key)
		return "<C-" .. key .. ">"
	end,
}

local function make_mappings(mappings, map_function)
	for big_key, maps in pairs(mappings) do
		for key, action in pairs(maps) do
			map_function(make_keymap[big_key](key), action)
		end
	end
end

local function make(modes)
	local mapping = {
		normal = function(keymap, action)
			vim.keymap.set("n", keymap, action, { noremap = true, silent = true })
		end,
		terminal = function(keymap, action)
			vim.keymap.set("t", keymap, action, { noremap = true, silent = true })
		end,
		visual = function(keymap, action)
			vim.keymap.set("v", keymap, action, { noremap = true, silent = true })
		end,
	}
	for mode, mappings in pairs(modes) do
		make_mappings(mappings, mapping[mode])
	end
end

local a = ":silent! %s/\\C\\(;;\\|\\\\'\\)a/á/g<CR>"
local e = ":silent! %s/\\C\\(;;\\|\\\\'\\)e/é/g<CR>"
local i = ":silent! %s/\\C\\(;;\\|\\\\'\\)i/í/g<CR>"
local o = ":silent! %s/\\C\\(;;\\|\\\\'\\)o/ó/g<CR>"
local u = ":silent! %s/\\C\\(;;\\|\\\\'\\)u/ú/g<CR>"

local am = ":silent! %s/\\C\\(;;\\|\\\\'\\)A/Á/g<CR>"
local em = ":silent! %s/\\C\\(;;\\|\\\\'\\)E/É/g<CR>"
local im = ":silent! %s/\\C\\(;;\\|\\\\'\\)I/Í/g<CR>"
local om = ":silent! %s/\\C\\(;;\\|\\\\'\\)O/Ó/g<CR>"
local um = ":silent! %s/\\C\\(;;\\|\\\\'\\)U/Ú/g<CR>"

local enye = ":silent! %s/\\C\\(\\~\\|;;\\|\\\\'\\)n/ñ/g<CR>"
local enyem = ":silent! %s/\\C\\(\\~\\|;;\\|\\\\'\\)N/Ñ/g<CR>"
--[^']*
local quotes = ":silent! %s/\"\\([^']*\\)\"/``\\1''/g<CR>"

local q_marks = ":silent! %s/??/¿/g<CR>"
local bangs = ":silent! %s/!!/¡/g<CR>"

vim.api.nvim_create_user_command("LatexLayout", "silent !i3-msg 'resize grow width 20 px or 20 ppt; move right'", {})

make(P)
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>xl", command("VimtexCompile"))
vim.keymap.set("n", "<leader>xe", command("VimtexErrors"))
vim.keymap.set("n", "<leader>xo", command("VimtexTocToggle"))
vim.keymap.set("n", "<leader>xs", command("VimtexStatus"))
vim.keymap.set("n", "<leader>xx", a .. e .. i .. o .. u .. am .. em .. um .. om .. um .. enye .. enyem .. quotes)
vim.keymap.set(
	"n",
	"<leader>sp",
	a .. e .. i .. o .. u .. am .. em .. um .. om .. um .. enye .. enyem .. q_marks .. bangs
)

vim.keymap.set("n", "<leader>sm", command("Telescope resume"), {
	noremap = true,
	silent = true,
	desc = "Resume",
})

vim.keymap.set("n", "<leader>bx", command("Telescope bibtex"), {
	noremap = true,
	silent = true,
	desc = "Resume",
})
function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

function punt_serch_and_replace(opts)
	search = opts.fargs[1]
	replace = opts.fargs[2]
	punctuation = "\\(\\ \\|;\\|,\\|\\.\\|:\\|\\)"
	final_punt = "\\(\\ \\|;\\|,\\|\\.\\|:\\)"
	-- print(search)
	-- print(replace)
	-- print(dump(s))
	vim.cmd("%s/\\C" .. punctuation .. search .. final_punt .. "/\\1" .. replace .. "\\2/gc")
end

function serch_and_replace(opts)
	search = opts.fargs[1]
	replace = opts.fargs[2]
	vim.cmd("%s/\\C" .. search .. "/" .. replace .. "/gc")
end

vim.api.nvim_create_user_command("PR", punt_serch_and_replace, { nargs = "*" })

vim.api.nvim_create_user_command("SR", serch_and_replace, { nargs = "*" })

function fsize(file)
	local current = file:seek() -- get current position
	local size = file:seek("end") -- get file size
	file:seek("set", current) -- restore position
	return size
end

function out_file(opts)
	filename = opts.fargs[1]
	print(filename)
	libs_file = io.open("out/" .. filename, "r")
	print(fsize(libs_file) / 1000000)
	libs_file:close()
end

vim.api.nvim_create_user_command("OutFile", out_file, { nargs = "*" })

vim.keymap.set("n", "<leader>ot", ":OutFile main.pdf<CR>")

vim.keymap.set("n", "<leader>dd", ":lua require('dap').continue()<CR>")
vim.keymap.set("n", "<leader>dk", ":lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>di", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<leader>do", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<leader>dh", ":lua require('dap.ui.widgets').hover()<CR>")
vim.keymap.set("n", "<leader>ds", ":lua require('dapui').toggle()<CR>")

vim.keymap.set("n", "<leader>zm", ":tab split<CR>")

vim.keymap.set(
	"n",
	"<leader>nn",
	":lua require('telescope.builtin').find_files({search_dirs={'~/Workspace/notes/'}})<CR>"
)
