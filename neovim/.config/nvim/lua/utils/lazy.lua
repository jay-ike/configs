require('lazy').setup({
  { import = 'plugins' },
}, {
  defaults = { lazy = false },
})

vim.cmd("source ~/.vim/jslint_wrapper_vim.vim")
