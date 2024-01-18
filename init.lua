require("settings")
require("mappings")
require("plugins")

require("plugins.rose-pine")
require('plugins.uuid-plugin')


function tesis()
  vim.cmd("VimtexCompile")
  vim.cmd("LatexLayout")
end

