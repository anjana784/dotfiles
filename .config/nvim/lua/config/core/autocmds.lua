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

