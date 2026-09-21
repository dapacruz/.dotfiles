-- ~/.config/nvim/lua/user/plugins/treesitter_textobjects.lua
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        include_surrounding_whitespace = false,
      },
      move = { set_jumps = true },
    })

    local select = require("nvim-treesitter-textobjects.select")

    -- Selection keymaps — preserves your original set exactly.
    local sel = {
      { "a=", "@assignment.outer",  "Select outer part of an assignment" },
      { "i=", "@assignment.inner",  "Select inner part of an assignment" },
      { "l=", "@assignment.lhs",    "Select left hand side of an assignment" },
      { "r=", "@assignment.rhs",    "Select right hand side of an assignment" },
      { "aP", "@parameter.outer",   "Select outer part of a parameter/argument" },
      { "iP", "@parameter.inner",   "Select inner part of a parameter/argument" },
      { "ac", "@conditional.outer", "Select outer part of a conditional" },
      { "ic", "@conditional.inner", "Select inner part of a conditional" },
      { "al", "@loop.outer",        "Select outer part of a loop" },
      { "il", "@loop.inner",        "Select inner part of a loop" },
      { "af", "@call.outer",        "Select outer part of a function call" },
      { "if", "@call.inner",        "Select inner part of a function call" },
      { "aF", "@function.outer",    "Select outer part of a function definition" },
      { "iF", "@function.inner",    "Select inner part of a function definition" },
      { "aC", "@class.outer",       "Select outer part of a class" },
      { "iC", "@class.inner",       "Select inner part of a class" },
    }
    for _, m in ipairs(sel) do
      local lhs, capture, desc = m[1], m[2], m[3]
      vim.keymap.set({ "x", "o" }, lhs, function()
        select.select_textobject(capture, "textobjects")
      end, { desc = desc })
    end

    local swap = require("nvim-treesitter-textobjects.swap")
    vim.keymap.set("n", "<leader>nP", function() swap.swap_next("@parameter.inner") end,
      { desc = "Swap next parameter" })
    vim.keymap.set("n", "<leader>nF", function() swap.swap_next("@function.outer") end,
      { desc = "Swap next function" })
    vim.keymap.set("n", "<leader>pP", function() swap.swap_previous("@parameter.inner") end,
      { desc = "Swap previous parameter" })
    vim.keymap.set("n", "<leader>pF", function() swap.swap_previous("@function.outer") end,
      { desc = "Swap previous function" })
  end,
}
