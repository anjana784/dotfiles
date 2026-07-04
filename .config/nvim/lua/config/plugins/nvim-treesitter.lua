return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  -- The main branch does NOT support lazy-loading
  lazy = false,
  dependencies = {
    "windwp/nvim-ts-autotag",
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main", lazy = false },
  },
  config = function()
    -- Install parsers (no-op if already installed, runs async)
    require("nvim-treesitter").install({
      "bash",
      "c",
      "cpp",
      "json",
      "lua",
      "markdown",
      "python",
      "rust",
      "vim",
      "yaml",
    })

    -- Enable treesitter highlighting for all filetypes
    -- (vim.treesitter.start() is a no-op for filetypes without a parser)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- Enable treesitter-based indentation
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        pcall(function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end)
      end,
    })

    -- Textobjects: select configuration
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "v",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = true,
      },
    })

    -- Textobjects: select keymaps (x = visual mode, o = operator-pending mode)
    local select = require("nvim-treesitter-textobjects.select")
    vim.keymap.set({ "x", "o" }, "af", function()
      select.select_textobject("@function.outer", "textobjects")
    end, { desc = "Select outer function" })
    vim.keymap.set({ "x", "o" }, "if", function()
      select.select_textobject("@function.inner", "textobjects")
    end, { desc = "Select inner function" })
    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end, { desc = "Select outer class" })
    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end, { desc = "Select inner class" })
    vim.keymap.set({ "x", "o" }, "as", function()
      select.select_textobject("@local.scope", "locals")
    end, { desc = "Select language scope" })
  end,
}
