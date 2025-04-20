local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
  green = '#2b8916',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
    x = {bg = colors.green, fg = colors.black},
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

return {
    { "nvim-tree/nvim-web-devicons"},
    {
        "NStefan002/screenkey.nvim",
        lazy = false,
        version = "*", -- or branch = "dev", to use the latest commit
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons"},
        event = "VeryLazy",
        config = function ()
            require('lualine').setup {
                options = {
                    theme = bubbles_theme,
                    component_separators = {right = ''},
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {
                            "NvimTree",
                            "TelescopePrompt",
                            "dashboard",
                            "lspinfo",
                            "mason",
                            "checkhealth",
                            "help",
                            "man",
                            "toggleterm",
                            "lazy",
                        },
                        winbar = {},
                        icons_enabled = true,
                        ignore_focus = {},
                        always_divide_middle = false,
                        globalstatus = false,
                        refresh = {
                            statusline = 1000,
                        },
                    },
               },
                sections = {
                    lualine_a = {
                        {
                            'mode',
                            separator = {left = '', right = ''},
                            icon = {" ", color = {fg = "#275409"}},
                            colored = true,
                            right_padding = 2,
                        }
                    },
                    lualine_b = {
                        {'branch', separator = {right = '',}},
                        {'diff', symbols = {added = " ", modified = " ", removed = " "}},
                        {'diagnostics'}
                    },
                    lualine_c = {
                        '%=',
                        {'filename', symbols = {modified = ' ●', readonly = '', newfile = '󰎔', unamed = ''}},
                        function()
                            return require("screenkey").get_keys()
                        end,
                    },
                    lualine_x = {
                        {
                            'fileformat',
                            symbols = {
                                unix = '', -- e712
                                dos = '',  -- e70f
                                mac = '',  -- e711
                            },
                            colored = true,
                            padding = 2,
                            separator = {left = '', right = ''},
                        },
                        {'encoding', separator = {right = ''}}
                    },
                    lualine_y = {
                        'filetype',
                        {'progress', separator = {right = ''}}
                    },
                    lualine_z = {
                        { 'location', separator = { right = '' }, left_padding = 2 },
                    },
                },
                inactive_sections = {
                    lualine_a = { 'filename' },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { 'location' },
                },
                extensions = {
                    "quickfix",
                    "aerial",
                },
            }
        end
    }
}
