-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }
--
-- require'lspconfig'.rust_analyzer.setup {
--   capabilities = capabilities,
-- }
require'lspconfig'.rust_analyzer.setup {
	settings = {
	["rust-analyzer"] = {
      assist = {
        importMergeBehavior = "last",
        importPrefix = "by_self",
      },
      diagnostics = {
        disabled = { "unresolved-import", "missing-unsafe" }
      },
      cargo = {
          loadOutDirsFromCheck = true
      },
      procMacro = {
          enable = true
      },
      checkOnSave = {
          command = "clippy"
      },
  }
		}
}
-- 	cmd = {DATA_PATH .. "/lspinstall/rust/rust_analyzer"},
-- 	on_attach = require'lsp'.common_on_attach
-- }
