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
vim.opt.completeopt = { 'menuone', 'popup' }
vim.lsp.config('ccls', {
    init_options = {
        cache = {
            directory = vim.env.HOME .. '/.cache/ccls'
        }
    },
    filetypes = { 'c', 'cc', 'cpp' },
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end,
        })
    end,
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

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'clojure', 'scheme' },
    callback = function()
        vim.keymap.set('i', '(', '()<left>')
        vim.keymap.set('i', '[', '[]<left>')
        vim.keymap.set('i', '{', '{}<left>')
        -- If char at cursor matches src, skip over. Otherwise, insert tgt.
        -- For closing parens, src == tgt. That is, if we're already at a
        -- closing paren, simply skip over. Otherwise, insert it.
        -- For quotes, if we're already at one we'd skip over. But if we're not,
        -- we do the same thing we do for opening parens -- insert two and then
        -- move left to leave cursor in middle.
        local function skip_or_insert(src, tgt)
            -- getpos() returns [_, lnum, col, _]. lnum and col are 1-indexed.
            local col = vim.fn.getpos('.')[3]
            -- string.sub() start and end are inclusive, 1-indexed
            local txt = vim.fn.getline('.'):sub(col, col)
            -- uncomment and view with :messages to debug
            -- vim.print(txt)
            if txt == src then
                return '<right>'
            else
                return tgt
            end
        end
        local function map_close_paren(s)
            vim.keymap.set('i', s, function()
                return skip_or_insert(s, s)
            end, {expr = true})
        end
        map_close_paren(')')
        map_close_paren(']')
        map_close_paren('}')
        local function map_quote(s)
            vim.keymap.set('i', s, function()
                return skip_or_insert(s, s .. s .. '<left>')
            end, {expr = true})
        end
        map_quote('"')
    end,
})
