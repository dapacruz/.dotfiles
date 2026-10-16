-- ~/.config/nvim/lua/user/plugins/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false, -- see note below about lazy-loading
    config = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        -- Explicit parser list. Add or remove to taste; :TSInstall <lang>
        -- also works at runtime. This call is idempotent.
        require("nvim-treesitter").install({
            -- config + docs
            "lua", "vim", "vimdoc", "query",
            "markdown", "markdown_inline",
            -- shells + data
            "bash", "yaml", "json", "toml",
            -- languages you write
            "python", "go", "gomod", "gosum", "gowork",
            -- infra / ops
            "hcl", "terraform", "dockerfile", "make", "regex",
            -- git
            "git_config", "gitcommit", "gitignore", "git_rebase", "gitattributes", "diff",
        })

        -- Start highlighting + indent per buffer. Replaces the old
        -- highlight = { enable = true } / indent = { enable = true } modules.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                if ft == "" or ft == "xml" then return end -- your original disable
                local lang = vim.treesitter.language.get_lang(ft) or ft
                if pcall(vim.treesitter.start, args.buf, lang) then
                    vim.bo[args.buf].indentexpr =
                    "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })

        -- Incremental selection: <M-Space> init/grow, <BS> shrink.
        local ts_selections = {}

        local function ts_select_range(srow, scol, erow, ecol)
            -- Treesitter end is exclusive; visual mode is inclusive.
            local end_row, end_col
            if ecol == 0 and erow > srow then
                end_row = erow - 1
                local line = vim.api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1] or ""
                end_col = math.max(#line - 1, 0)
            else
                end_row = erow
                end_col = math.max(ecol - 1, 0)
            end

            -- Force back to normal mode before re-entering visual.
            if vim.fn.mode() ~= "n" then
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                    "nx", false
                )
            end

            vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
            vim.cmd("normal! v")
            vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
        end

        local function ts_init_selection()
            local buf = vim.api.nvim_get_current_buf()
            local node = vim.treesitter.get_node()
            if not node then return end
            ts_selections[buf] = { node }
            ts_select_range(node:range())
        end

        local function ts_grow_selection()
            local buf = vim.api.nvim_get_current_buf()
            local stack = ts_selections[buf]
            if not stack or #stack == 0 then
                return ts_init_selection()
            end
            local parent = stack[#stack]:parent()
            if not parent then return end
            table.insert(stack, parent)
            ts_select_range(parent:range())
        end

        local function ts_shrink_selection()
            local buf = vim.api.nvim_get_current_buf()
            local stack = ts_selections[buf]
            if not stack or #stack <= 1 then return end
            table.remove(stack)
            ts_select_range(stack[#stack]:range())
        end

        vim.keymap.set("n", "<M-Space>", ts_init_selection,   { desc = "TS: init selection" })
        vim.keymap.set("x", "<M-Space>", ts_grow_selection,   { desc = "TS: grow selection" })
        vim.keymap.set("x", "<BS>",      ts_shrink_selection, { desc = "TS: shrink selection" })

        vim.api.nvim_create_autocmd("BufWipeout", {
            callback = function(args) ts_selections[args.buf] = nil end,
        })    end,
}
