return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                attach_to_untracked = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
                on_attach = function(bufnr)
                    local gs = require("gitsigns")

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]h", function()
                        if vim.wo.diff then
                            return "]h"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Gitsigns: next hunk" })

                    map("n", "[h", function()
                        if vim.wo.diff then
                            return "[h"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Gitsigns: prev hunk" })

                    -- Actions
                    map(
                        "n",
                        "<leader>ht",
                        gs.toggle_current_line_blame,
                        { desc = "Gitsigns: toggle current line blame" }
                    )
                    map("n", "<leader>hd", gs.diffthis, { desc = "Gitsigns diff" })
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end, { desc = "Gitsigns diff ~" })

                    -- Text object
                    map(
                        { "o", "x" },
                        "ih",
                        ":<C-U>Gitsigns select_hunk<CR>",
                        { desc = "Gitsigns hunk text object" }
                    )
                end,
            })
        end,
    },
    {
        "isakbm/gitgraph.nvim",
        dependencies = { "sindrets/diffview.nvim" },
        keys = {
            {
                "<leader>gg",
                function()
                    require("gitgraph").draw({}, { all = true, max_count = 5000 })
                end,
                desc = "GitGraph - Draw",
            },
        },
        opts = {
            hooks = {
                -- Check diff of a commit
                on_select_commit = function(commit)
                    vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
                end,
                -- Check diff from commit a -> commit b
                on_select_range_commit = function(from, to)
                    vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
                end,
            },
        },
    },
    {
        'akinsho/git-conflict.nvim',
        lazy = false,
        version = "v2.1.0",
        opts = {
            default_mappings = true,
            default_commands = true,
            list_opener = "copen",
        }
    }
}
