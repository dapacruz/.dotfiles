local severity = vim.diagnostic.severity
local keymap = vim.keymap

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local function opts(desc)
            return { desc = "LSP: " .. desc, buffer = ev.buf, silent = true }
        end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        -- set keybinds
        keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts("LSP: Go to definition"))
        keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts("LSP: Go to declaration"))
        keymap.set("n", "gI", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts("LSP: Go to implementation"))
        keymap.set("n", "<M-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts("LSP: Signature help"))
        keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts("LSP: Get all references"))
        keymap.set("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts("LSP: Rename symbol"))
        keymap.set("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts("LSP: Code action"))
        keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("LSP: Get type definition"))
        keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("LSP: Add workspace folder"))
        keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("LSP: Remove workspace folder"))
        keymap.set("n", "<leader><leader>d", '<Cmd>lua vim.diagnostic.open_float({ border="rounded" })<CR>',
            opts("LSP: Open diagnostic float"))
        keymap.set("n", "[d", '<Cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
            opts("LSP: Go to previous diagnostic"))
        keymap.set("n", "]d", '<Cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
            opts("LSP: Go to next diagnostic"))
        keymap.set("n", "<leader>dll", "<Cmd>lua vim.diagnostic.setloclist()<CR>",
            opts("LSP: Send all diagnostics to a location list"))

        keymap.set("n", "K", function()
            vim.lsp.buf.hover {
                border = 'rounded',
                max_width = 90,
                max_height = 40,
            }
        end, opts("LSP: Show hover information about the symbol under the cursor"))

        keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts("LSP: List workspace folders"))

        keymap.set("n", "<leader>di", function()
            if vim.diagnostic.config().virtual_text then
                vim.diagnostic.config({ virtual_text = false })
            else
                vim.diagnostic.config({ virtual_text = true })
            end
        end, opts("LSP: Toggle diagnostic virtual text"))

        vim.cmd([[ command! Format execute "lua vim.lsp.buf.format({async=true})" ]])
        keymap.set("n", "<space>F", function()
            vim.lsp.buf.format { async = true }
        end, opts("LSP: Format current buffer"))
    end,
})


local config = {
    signs = {
        text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰠠 ",
            [severity.INFO] = " ",
        },
    },
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}
vim.diagnostic.config(config)
