return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview file history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview branch history" },
  },
  opts = {
    enhanced_diff_hl = true, -- better diff highlights (additions/deletions within lines)
    view = {
      merge_tool = {
        layout = "diff3_mixed", -- 3-way diff for merge conflicts
      },
    },
  },
}
