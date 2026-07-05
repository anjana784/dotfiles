-- Auto-start server for nvim-remote (used by lazygit to open files in existing instance)
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Start server for remote editing (lazygit integration)",
  callback = function()
    -- serverstart() with no args auto-generates a socket address
    -- Returns the address on success, "0" on failure
    vim.fn.serverstart()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
  desc = "Remove trailing spaces before saving",
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*",
  command = ":retab",
  desc = "Convert tabs to spaces on file open",
})

-- Set winbar to show project-relative file path
-- Uses a dynamic %{v:lua...} expression so it updates automatically per-window
vim.api.nvim_create_autocmd({ "BufEnter", "WinNew" }, {
  desc = "Set winbar with project-relative path",
  callback = function()
    vim.wo.winbar = "%{%v:lua.require('config.core.winbar').get_relative_path()%}"
  end,
})

-- Markdown: enable line wrapping for comfortable reading
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  desc = "Enable word-wrapped lines and render-markdown friendly options for markdown files",
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    vim.wo.conceallevel = 2
    vim.wo.concealcursor = "nvc"
  end,
})

