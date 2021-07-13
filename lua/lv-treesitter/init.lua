require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = O.treesitter.ignore_install,
    highlight = {
        enable = true -- false will disable the whole extension
    },
    -- indent = {enable = true, disable = {"python", "html", "javascript"}},
    -- TODO seems to be broken
    indent = {enable = {"python"}},
    autotag = {enable = true},
}

