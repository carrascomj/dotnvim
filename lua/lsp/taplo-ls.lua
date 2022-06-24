require("lspconfig").taplo.setup({
	-- init_options = {initializationOptions},
	cmd = {"taplo", "lsp", "stdio"},
	filetypes = { "toml" },
})
