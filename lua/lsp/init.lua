-- Override virtual text in onedark.vim with dimmer colors
vim.cmd([[highlight! VWarn guifg='#77765c']])
vim.cmd([[highlight! VError guifg='#885c5c']])
vim.cmd([[highlight! VHint guifg='#745675']])
vim.cmd([[highlight! VInfo guifg='#5c7776']])
vim.cmd([[highlight! HHint guifg='#4c515f']])

vim.cmd("highlight! link CmpItemAbbr VInfo")
vim.cmd("highlight! link CmpItemMenu VHint")
vim.cmd("highlight! link DiagnosticVirtualTextError VError")
vim.cmd("highlight! link DiagnosticVirtualTextWarn VWarn")
vim.cmd("highlight! link DiagnosticVirtualTextHint VHint")
vim.cmd("highlight! link DiagnosticVirtualTextInfo VInfo")
vim.cmd("highlight! link DiagnosticUnderlineHint HHint")
vim.cmd("highlight! link DiagnosticHint VHint")

vim.fn.sign_define(
	"DiagnosticSignError",
	{ texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError" }
)
vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "DiagnosticSignInfo" })

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- vim.api.nvim_set_keymap('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_set_keymap("n", "gv", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "gb", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", ";", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

vim.cmd[[autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }]]

-- show name of Language Server on diganostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		source = "always", -- Or "if_many"
	},
})

-- symbols for autocomplete
-- vim.lsp.protocol.CompletionItemKind = {
--     "   (Text) ",
--     "   (Method)",
--     "   (Function)",
--     "   (Constructor)",
--     "   (Field)",
--     "[] (Variable)",
--     "   (Class)",
--     " ﰮ  (Interface)",
--     "   (Module)",
--     " 襁 (Property)",
--     "   (Unit)",
--     "   (Value)",
--     "  (Enum)",
--     "   (Keyword)",
--     " ﬌  (Snippet)",
--     "   (Color)",
--     "   (File)",
--     "   (Reference)",
--     "   (Folder)",
--     "   (EnumMember)",
--     " ℏ  (Constant)",
--     "   (Struct)",
--     "   (Event)",
--     "   (Operator)",
--     "   (TypeParameter)"
-- }

--[[ " autoformat
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100) ]]
-- Java
-- autocmd FileType java nnoremap ca <Cmd>lua require('jdtls').code_action()<CR>

local function documentHighlight(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end
local lsp_config = {}

function lsp_config.common_on_attach(client)
	documentHighlight(client)
end

function lsp_config.tsserver_on_attach(client, bufnr)
	lsp_config.common_on_attach(client)
	client.resolved_capabilities.document_formatting = false
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = {"pyright", "tsserver"}
-- for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
return lsp_config
