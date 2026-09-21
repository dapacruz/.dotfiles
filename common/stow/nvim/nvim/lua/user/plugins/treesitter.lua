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
      "yaml",
      -- basics for your own config + render-markdown:
      "lua", "vim", "vimdoc", "query",
      "markdown", "markdown_inline",
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
  end,
}
