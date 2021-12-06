local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
-- Check if it's already defined for when reloading this file.
if not lspconfig.foo_lsp then
	configs.foo_lsp = {
		default_config = {
			cmd = { [[vale --config="$VALE_CONFIG/vale.ini" --output JSON]] },
			filetypes = { "markdown", "text" },
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
			end,
			settings = {},
		},
	}
end
lspconfig.foo_lsp.setup({})
