return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            {"L3MON4D3/LuaSnip", build = "make install_jsregexp"},
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },

        config = function()
            local cmp = require('cmp')
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())
            local lsp = require("lspconfig")

            lsp.dartls.setup({
                cmd = { "dart", "language-server", "--protocol=lsp" },
                filetypes = { "dart" },
                init_options = {
                    closingLabels = true,
                    flutterOutline = true,
                    onlyAnalyseProjectsWithOpenFiles = true,
                    outline = true,
                    suggestFromUnimportedLibraries = true,
                },
                settings = {
                    dart = {
                        completeFunctionCalls = true,
                        showTodos = true,
                    },
                },
            })
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "",
                        package_pending = "",
                        package_uninstalled = "",
                    },
                }
            })
            require("mason-lspconfig").setup({
                on_attach = function(client, bufnr)
                    if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint ~= nil then
                        vim.keymap.set("n", "<leader>in", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                                { bufnr = bufnr }
                            ) -- toggle
                        end, { desc = "Lsp-[In]layhints Toggle", buffer = bufnr })
                        local inlay_hint_grp = vim.api.nvim_create_augroup("InlayHintsInInsert", {})
                        vim.api.nvim_create_autocmd("InsertLeave", {
                            group = inlay_hint_grp,
                            pattern = "*",
                            callback = function()
                                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                            end,
                            desc = "Hide inlay hints",
                        })
                        vim.api.nvim_create_autocmd("InsertEnter", {
                            group = inlay_hint_grp,
                            pattern = "*",
                            callback = function()
                                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                            end,
                            desc = "Show inlay hints",
                        })
                    end
                end,
                ensure_installed = {
                    "ts_ls",
                    "lua_ls",
                    "rust_analyzer",
                    "gopls",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        if server_name == "tsserver" then
                            server_name = "ts_ls"
                        end
                        lsp[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    zls = function()
                        lsp.zls.setup({
                            root_dir = lsp.util.root_pattern(".git", "build.zig", "zls.json"),
                            settings = {
                                zls = {
                                    enable_inlay_hints = true,
                                    enable_snippets = true,
                                    warn_style = true,
                                },
                            },
                        })
                        vim.g.zig_fmt_parse_errors = 0
                        vim.g.zig_fmt_autosave = 0
                    end,
                    html = function ()
                        lsp.html.setup({
                            filetypes = {"html", "ejs", "nunjucks"}
                        })
                    end,
                    jinja_lsp = function ()
                        lsp.jinja_lsp.setup({
                            filetypes = {"jinja", "nunjucks"}
                        })
                    end,
                    emmet_language_server = function ()
                        lsp.emmet_language_server.setup({
                            filetypes = {"css", "eruby", "html", "javascript", "javascriptreact", "less", "pug", "sass", "scss", "typescriptreact", "ejs", "nunjucks"},
                        })
                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    diagnostics = {
                                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            }
                        }
                    end,
                }
            })

            local luasnip = require('luasnip')
            vim.filetype.add({ extension = { ejs = "ejs"}})
            vim.filetype.add({ extension = { njk = "nunjucks"}})
            luasnip.filetype_set("ejs", { "html", "javascript", "ejs"})
            luasnip.filetype_set("nunjucks", {"html", "njk"})
            require("luasnip.loaders.from_vscode").load({paths = {"~/.vim/my_snippets"}})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-j>'] = cmp.mapping.scroll_docs(4),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.expand_or_jumpable(-1) then
                            luasnip.expand_or_jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                        { name = 'buffer' },
                    })
            })
            local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false
            })
        end
    },
}
