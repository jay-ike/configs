return {
    {
        'echasnovski/mini.nvim',
        event = 'VeryLazy',
        config = function()
            require("mini.ai").setup {
                -- Better Around/Inside textobjects
                --
                -- Examples:
                --  - va)  - [V]isually select [A]round [)]parenthen
                --  - yinq - [Y]ank [I]nside [N]ext [']quote
                --  - ci'  - [C]hange [I]nside [']quote
                n_lines = 500,
            }
            require("mini.surround").setup {
                -- Add/delete/replace surroundings (brackets, quotes, etc.)
                --
                -- - gsaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
                -- - gsd'   - [S]urround [D]elete [']quotes
                -- - gsr)'  - [S]urround [R]eplace [)] [']
                mappings = {
                    add = 'gsa', -- Add surrounding in Normal and Visual modes
                    delete = 'gsd', -- Delete surrounding
                    find = 'gsf', -- Find surrounding (to the right)
                    find_left = 'gsF', -- Find surrounding (to the left)
                    highlight = 'gsh', -- Highlight surrounding
                    replace = 'gsr', -- Replace surrounding
                    update_n_lines = 'gsn', -- Update `n_lines`

                },
            }
            -- require("mini.operators").setup()
            -- require("mini.pairs").setup()
            -- require("mini.bracketed").setup()
            -- require("mini.files").setup()
        end
    },
    { "rcarriga/nvim-notify", opts = { timeout = 5000 } }
}
