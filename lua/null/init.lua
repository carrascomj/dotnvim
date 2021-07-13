local null_ls = require("null-ls")
local sources = {
    null_ls.builtins.diagnostics.vale.with({filetypes={"markdown", "txt", "tex"}}),
}
null_ls.setup {sources = sources}
