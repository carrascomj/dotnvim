require("gitsigns").setup({
	signs = {
		-- TODO add hl to colorscheme
		add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	numhl = true,
	linehl = false,
	keymaps = {
		-- Default keymap options
		noremap = true,
		buffer = true,
		["n gt"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
	},
	watch_gitdir = {
		interval = 1000,
	},
	sign_priority = 6,
	update_debounce = 200,
	status_formatter = nil, -- Use default
})
