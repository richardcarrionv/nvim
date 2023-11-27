require("settings")
require("mappings")
require("plugins")

require("plugins.rose-pine")

function tesis()
  vim.cmd("VimtexCompile")
  vim.cmd("LatexLayout")
end
