vim.cmd("let g:nvcode_termcolors=256")

vim.cmd("colorscheme " .. O.colorscheme)
require("colorizer").setup()

-- Telescope bunting
vim.cmd([[highlight TelescopeBorder guifg=#494b53]])
vim.cmd([[highlight TelescopeSelectionCaret guifg=#e5c07b]])
vim.cmd([[highlight TelescopeSelection gui=bold guibg=#393b43]])
vim.cmd([[highlight TelescopeMatching guifg=#ca1243]])
