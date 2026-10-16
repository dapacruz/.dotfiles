vim.opt.backup = false
vim.opt.bs = "2" -- Make backspace behave like normal again
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = "osc52"
vim.opt.cmdheight = 1 --  Give more space for displaying messages
vim.opt.cursorcolumn = false
vim.opt.cursorline = true -- Cursor highlighting
vim.opt.diffopt:append("vertical") -- Always use vertical windows for diffsplit,
vim.opt.encoding = "utf-8"
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.fo:remove("t") -- Don't automatically wrap text when typing
vim.opt.guicursor = "a:ver1-blinkon100,n:block-blinkon100"
vim.opt.guifont = { "VictorMono Nerd Font:h13" }
vim.opt.hidden = true -- When on a buffer becomes hidden when it is abandoned
vim.opt.history = 700 -- Useful settings
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- Make search case insensitive
vim.opt.incsearch = true
vim.opt.isfname:append("@-@")
vim.opt.list = true -- Displays a hypen where there is whitespace
vim.opt.matchpairs:append("<:>")
vim.opt.mouse = "a" -- On OSX press ALT and click mouse and backspace
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.tw = 79 -- Width of document (used by gd)
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.undolevels = 700
vim.opt.updatetime = 50 -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false
vim.opt.laststatus = 3

if vim.fn.has("mac") == 1 then
    vim.opt.shell = "/opt/homebrew/bin/zsh"
else
    vim.opt.shell = "/home/linuxbrew/.linuxbrew/bin/zsh"
end

-- Enable vim-visual-multi mouse mappings
vim.g.VM_mouse_mappings = 1
vim.g.VM_theme = "codedark"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

