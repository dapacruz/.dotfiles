return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "ansiblels",
                "bashls",
                "cssls",
                "gopls",
                "html",
                "jedi_language_server",
                "jsonls",
                "lua_ls",
                "terraformls",
                "tflint",
                "vimls",
                "vtsls",
                "yamlls",
            },
        },
        dependencies = {
            "neovim/nvim-lspconfig", -- enable native LSP
            {
                "williamboman/mason.nvim",  -- language server installer
                config = function()
                    require("mason").setup({
                        automatic_installation = true,
                        ui = {
                            icons = {
                                package_installed = "✓",
                                package_pending = "➜",
                                package_uninstalled = "✗"
                            }
                        }
                    })
                end,
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "ansible-lint",
                "tree-sitter-cli",
            },
        },
        dependencies = {
            "mason-org/mason.nvim",
        },
    },
}
