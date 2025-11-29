return {
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_contrast_dark = 'hard'
            vim.cmd.colorscheme "gruvbox"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
    },
    { "neovim/nvim-lspconfig", },
    { "nvim-tree/nvim-web-devicons", },
    { "nvim-tree/nvim-tree.lua", },
    -- { "vim-airline/vim-airline", },
    {
        "Olical/conjure",
        lazy = true,
        ft = {"clojure", "scheme"},
        -- init = function()
        --     vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
        --     vim.g["conjure#client#guile#socket#pipename"] = "/tmp/.guile-repl.socket"
        -- end,
    },
}
