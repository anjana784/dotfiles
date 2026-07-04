return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Lazygit (toggle)" },
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit (toggle)" },
    { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "Lazygit current file" },
    { "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "Lazygit filter current file" },
  },
  config = function()
    local lazygit = require("lazygit")

    -- Toggle: close if any lazygit window is open, else open
    local function lazygit_toggle()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "lazygit" then
          vim.api.nvim_win_close(win, true)
          return
        end
      end
      lazygit.lazygit()
    end

    -- User command for toggle
    vim.api.nvim_create_user_command("LazyGitToggle", lazygit_toggle, {
      desc = "Toggle lazygit floating window",
    })

    -- Remap to use toggle behavior (overrides lazy.nvim keys table mappings)
    vim.keymap.set("n", "<leader>lg", lazygit_toggle, { desc = "Lazygit (toggle)" })
    vim.keymap.set("n", "<leader>gg", lazygit_toggle, { desc = "Lazygit (toggle)" })
  end,
}
