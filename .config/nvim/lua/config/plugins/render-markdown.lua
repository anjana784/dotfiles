return {
  "MeanderingProgrammer/render-markdown.nvim",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    heading = {
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    checkbox = {
      enabled = true,
    },
    pipe_table = {
      enabled = true,
    },
  },
}
