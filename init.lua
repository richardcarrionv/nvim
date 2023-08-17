require("settings")
require("mappings")
require("plugins")

require("plugins.tokyonight")

function tesis()
  vim.cmd("VimtexCompile")
  vim.cmd("LatexLayout")
end
