function refresh()
  -- os.execute("pkill -HUP mupdf-gl")
  print("HOLA")
end

vim.cmd(
  [[  autocmd VimEnter * augroup vimtex_event_1 | au! | au User VimtexEventCompileSuccess call system('pkill -HUP mupdf-gl') | augroup END]])


vim.g.vimtex_view_method              = 'mupdf'
vim.g.vimtex_quickfix_mode            = 0
vim.g.vimtex_compiler_latexmk         = {
  out_dir = 'out',
  options = { '--shell-escape' },
}
vim.g.vimtex_quickfix_ignore_filters  = {
  'Underfull',
  'Overfull',
  "Token not allowed in a PDF string",
}
vim.g.vimtex_compiler_latexmk_engines = {
  luatex = '-pdf -pdflatex=luatex',
  luatex = '-lualatex',
}
vim.g.vimtex_view_automatic           = 0
vim.g.vimtex_mappings_enabled         = 0
vim.g.vimtex_toc_config               = {
  layer_status = {
    content = 1,
    label = 0,
    todo = 0,
    include = 0
  },
  indent_levels = 1,
  show_help = 0,
  show_numbers = 0,
}

-- vim.api.nvim_create_autocmd({ "VimtexEventCompileSuccess" }, { callback = refresh }--[[ ) ]]
