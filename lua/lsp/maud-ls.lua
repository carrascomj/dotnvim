local util = require 'lspconfig.util'

local lspconfig = require'lspconfig'
local configs = require'lspconfig.configs'

local hover_csv = function()
  -- vim.cmd[[%CSVUnArrangeColumn]]
  vim.lsp.buf.hover()
end

local goto_csv = function()
  -- vim.cmd[[%CSVUnArrangeColumn]]
  vim.lsp.buf.definition()
end


if not configs.maud then
  configs.maud = {
  default_config = {
    filetypes = { 'toml', 'csv' },
    -- Should be in your path
    cmd = {'maud-lsp'},
    root_dir = function(fname)
      local root = util.root_pattern(unpack({"config.toml"}))(fname)
      return root
    end,
    on_attach = function (client, bufnr)
			
      if vim.fn.getbufvar(bufnr, "&filetype") == "csv" then
       local bufopts = { noremap=true, silent=true, buffer=bufnr } 
       vim.keymap.set('n', 'K', hover_csv, bufopts)
       vim.keymap.set('n', 'gd', goto_csv, bufopts)
      end
    end,
    single_file_support = true,
  },
  docs = {
    description = [[
		Maud stuff
]],
  },
  };
end
lspconfig.maud.setup{}
