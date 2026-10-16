-- Trim leading and trailing whitespace
vim.cmd([[ command! -range=% TrimWhitespace <line1>,<line2>s/^\s\+//e | <line1>,<line2>s/\s\+$//e ]])
vim.cmd([[ command! -range=% TrimWhitespaceTrailing <line1>,<line2>s/\s\+$//e ]])

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local user_group = augroup('user', {})

-- Flash highlight on yank
autocmd('TextYankPost', {
    group = user_group,
    pattern = '*',
    callback = function()
        vim.hl.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Disable automatic continuation of comments on newline
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.filetype.add({
    extension = {
        tmpl = "html",
        tf = "terraform",
        tfvars = "terraform-vars",
    },
    pattern = {
        [".+/playbooks/.+%.ya?ml"] = "yaml.ansible",
        [".+/playbooks/tasks/.+%.ya?ml"] = "yaml.ansible",
        [".+/ansible/inventory%.ya?ml"] = "yaml.ansible",
    },
})

-- Format Go files
autocmd({ "InsertLeave" }, {
    group = user_group,
    pattern = "*.go",
    command = "silent lua vim.lsp.buf.format({async=true})",
})

autocmd({ "BufWritePost" }, {
    group = user_group,
    pattern = "*.go",
    command = "silent !goimports -w %",
})

-- Format Python files
autocmd({ "BufWritePost" }, {
    group = user_group,
    pattern = "*.py",
    command = "silent !ruff format --quiet",
})

-- Format Python imports
autocmd({ "BufWritePost" }, {
    group = user_group,
    pattern = "*.py",
    command = "silent !ruff check --select I --fix",
})

autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
    group = user_group,
    pattern = "*.rs",
    callback = function()
        require("lsp_extensions").inlay_hints {}
    end
})

-- Remove trailing whitespace
autocmd({ "BufWritePre" }, {
    group = user_group,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

-- Return to previous line when last closed
autocmd({ "BufRead" }, {
    group = user_group,
    pattern = "*",
    command = [[call setpos(".", getpos("'\""))]],
})

-- Disable LSP diagnostics for noisy non-standard CSS configs (Waybar, etc.)
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = {
        "*/waybar/style.css",
    },
    callback = function(args)
        vim.diagnostic.enable(false, { bufnr = args.buf })
    end,
})

