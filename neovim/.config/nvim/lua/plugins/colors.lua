return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function()
            local schemes_candidates = {
                "random",
                "default",
                "tokyonight-night",
                "tokyonight-storm",
                "tokyonight-moon",
                "tokyonight-day",
                "light",
            }

            vim.keymap.set("n", "<leader>col", function()
                vim.ui.select(schemes_candidates, {
                    promt = "Select colorscheme",
                }, function(selected)
                    local selection = selected
                    if not selected then
                        return
                    end
                    if selected == "random" then
                        -- do not select light themes
                        local random_scheme =
                            schemes_candidates[math.random(2, #schemes_candidates - 2)]
                        selection = random_scheme
                    end
                    if selection == "light" then
                        vim.cmd("set background=light")
                        vim.cmd("TransparentDisable")
                    else
                            vim.cmd.colorscheme(selection)
                    end
                end)
            end)
            require("tokyonight").setup({
                transparent = true,
                terminal_colors = true
            })
            vim.cmd [[colorscheme tokyonight]]
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
            require("transparent").setup({
                extra_groups = { "NvimTreeNormal", "FloatBorder" }, -- table: additional groups that should be cleared
                exclude_groups = { "TreesitterContext" },           -- table: groups you don't want to clear
            })
            vim.cmd("TransparentDisable")
        end,
    },
}
