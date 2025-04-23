vim.g.mapleader = " "

vim.opt.guicursor = ""

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.spell = true
vim.opt.spelllang = { "en_gb" }


-- default position
vim.opt.scrolloff = 8     -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right

-- search
vim.opt.ignorecase = true

vim.filetype.add({
    extension = { templ = 'templ' }
})

vim.g.have_nerd_font = true
