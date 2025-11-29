require("config.lazy")

-- Disable netrw in favour of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Configure treesitter
require('nvim-treesitter').install({'c', 'cpp', 'scheme'})
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cpp', 'scheme' },
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- Configure LSP
vim.lsp.config('ccls', {
    init_options = {
        cache = {
            directory = vim.env.HOME .. '/.cache/ccls'
        }
    },
    filetypes = { 'c', 'cc', 'cpp' },
})
vim.lsp.enable('ccls')

-- Configure nvim-tree
require("nvim-tree").setup()

-- Options
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.wildignore = '*.o,*~,*.pyc'
vim.o.backspace = 'eol,start,indent'
vim.o.whichwrap = '<,>,h,l'

-- Keymaps
vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', '<F1>', '<esc>')
vim.keymap.set('i', '<C-o>', '<left><cr><esc>O')

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(opts)
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
    end,
})
