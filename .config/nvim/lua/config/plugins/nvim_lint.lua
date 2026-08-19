return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "ruff" },
    }

    -- Monorepo: run linters from the buffer's nearest package.json root so
    -- eslint_d picks up the workspace's config (e.g. apps/web) instead of
    -- falling back to Neovim's cwd (the repo root, which has no config).
    local function lint_cwd()
      local bufdir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
      local pkg = vim.fs.find("package.json", { upward = true, path = bufdir, type = "file" })[1]
      return pkg and vim.fs.dirname(pkg) or bufdir
    end

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint(nil, { cwd = lint_cwd() })
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint(nil, { cwd = lint_cwd() })
    end, { desc = "Trigger linting for current file" })
  end,
}
