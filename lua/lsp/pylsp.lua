require("lspconfig").pylsp.setup({
	-- init_options = {initializationOptions},
	-- cmd = {"/home/georg/.local/bin/pylsp"},
	cmd = {"python", "-m", "pylsp"},
	filetypes = { "python" },
	settings = {
		configurationSources = {"flake8"},
		formatCommand = {"black"}
  }
})
