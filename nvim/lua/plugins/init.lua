return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        opts = {
            italic = { strings = false },
            contrast = "hard",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
    },
    { "neovim/nvim-lspconfig", },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
        },
    },
    { "nvim-tree/nvim-web-devicons", },
    { "nvim-tree/nvim-tree.lua", },
    -- { "vim-airline/vim-airline", },
    {
        "Olical/conjure",
        lazy = true,
        ft = {"clojure", "scheme"},
    },
    -- { "PaterJason/nvim-treesitter-sexp", },
    -- { "guns/vim-sexp", },
    -- { "tpope/vim-sexp-mappings-for-regular-people", },
    -- { "Raimondi/delimitMate", },
}
