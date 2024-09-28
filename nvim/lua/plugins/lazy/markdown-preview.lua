return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    init = function ()
        vim.g.mkdp_filetypes = {"markdown"}
        vim.g.mkdp_port = "4040"
        vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end
}
