return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opt = {

  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight-moon")
  end,
}
