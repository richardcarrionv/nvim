P = {}

local function command(action)
    return ":" .. action .. " <CR>"
end

local terminal = ""
local config_path = "~/.config/nvim/"
local isWindows = vim.fn.has("win32")


if isWindows then
    terminal = "powershell.exe"
    config_path = "~/AppData/Local/nvim/"
end



P.terminal = {
    none = {
        ["<Esc>"] = "<C-\\><C-n>"
    },
}

P.normal = {
    leader = {
        ["<Enter>"] = "o<Esc>",
        [">"] = "5<C-w>>",
        ["<"] = "5<C-w><",
        ["+"] = "5<C-w>+",
        ["-"] = "5<C-w>-",
        ["."] = command("Telescope file_browser path=%:p:h select_buffer=true"),
        --A
        --B
        --C
        -- ca = {code action}
        co = command("tabnew | tcd "..config_path.." | edit lua/plugins.lua  | vsplit init.lua "),
        --D
        df = command("Gitsign diffthis"),
        di = command("Trouble document_diagnostics"),
        --F
        fl = command("Telescope find_files"),
        ff = command("Telescope buffers"),
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
        tt = command("tabnew | terminal "..terminal) .. "i",
        ts = command("vsplit | terminal "..terminal) .. "i",
        ti = command("split | terminal "..terminal) .. "i",
        --U
        --V
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
        end
    }
    for mode, mappings in pairs(modes) do
        make_mappings(mappings, mapping[mode])
    end
end

make(P)
vim.keymap.set("x", "<leader>p", [["_dP]])
