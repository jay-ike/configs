local autocmd = vim.api.nvim_create_autocmd;
local augroup = vim.api.nvim_create_augroup;
local JayIkeGroup = augroup('JayIke', {})
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- remove extra spaces at the end of every line before writing
autocmd({ "BufWritePre" }, {
    group = JayIkeGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = JayIkeGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})


autocmd('BufWritePost', {
  pattern = { '*tmux.conf' },
  command = "execute 'silent !tmux source <afile> --silent'",
})

autocmd('BufWritePost', {
  pattern = { 'yazi.toml' },
  command = "execute 'silent !yazi --clear-cache'",
})

-- autocmd('BufWritePost', {
--   pattern = { 'config.fish' },
--   command = "execute 'silent !source <afile> --silent'",
-- })

autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
  pattern = { '*.mdx', '*.md' },
  callback = function()
    vim.cmd [[set filetype=markdown wrap linebreak nolist nospell]]
  end,
})

autocmd({ 'BufRead' }, {
  pattern = { '*.conf' },
  callback = function()
    vim.cmd [[set filetype=sh]]
  end,
})

autocmd({ 'BufRead' }, {
  -- https://ghostty.org/docs/config/reference
  pattern = { 'config' },
  callback = function()
    vim.cmd [[set filetype=toml]]
    vim.cmd [[LspStop]]
  end,
})
