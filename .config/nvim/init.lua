vim.g.have_nerd_font = false
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.number = true
vim.o.rnu = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = 'unnamedplus'

vim.g.netrw_bufsettings = 'noma nomod nowrap ro nobl nu rnu'

vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
}

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', '<c-space>', function() vim.lsp.completion.get() end)
vim.keymap.set('n', '<leader>se', '<cmd>Explore<CR>')
vim.keymap.set('n', '<leader>sf', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep<cr>')

vim.cmd.colorscheme 'tokyonight-night'

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.lsp.completion.enable(true, args.data.client_id, args.buf)
    end
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('pylsp')
