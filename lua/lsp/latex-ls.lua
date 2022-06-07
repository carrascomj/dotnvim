require("lspconfig").texlab.setup({
	cmd = { "texlab" },
	on_attach = require("lsp").common_on_attach,
	settings = {
		texlab = {
			build = {
				onSave = true;
			},
			forwardSearch = {
				executable = "zathura",
				args = {"--synctex-forward", "%l:1:%f", "%p"},
				onSave = true;
			}
		}
	}
})
