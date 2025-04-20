require('lazy').setup({
  { import = 'plugins' },
}, {
  defaults = { lazy = true },
})

vim.cmd("source ~/.vim/jslint_wrapper_vim.vim")
