-- ~/.config/nvim/init.lua

-- Set up 'runtimepath' or any minimal settings before loading the rest
-- For example, if you want to ensure that 'lazy.nvim' is installed, etc.

require("config.core.options") -- Immediately set basic Vim/Neovim options
require("config.core.keymaps") -- Basic key mappings
require("config.core.autocmds") -- Any autocommands you want right away

-- Load lazy.nvim (and all plugins)
require("config.plugins.init")

-- Function to reload the window
local function ReloadWindow()
	-- Source the init file to reload the configuration
	vim.cmd("source " .. vim.env.MYVIMRC)

	-- Check for changes in open buffers
	vim.cmd("checktime")

	-- Restart LSP if active
	if vim.fn.exists(":LspRestart") == 2 then
		vim.cmd("LspRestart")
	end
end

-- Create a user command to call the function
vim.api.nvim_create_user_command("ReloadWindow", ReloadWindow, {})

-- Map the function to a keybinding (e.g., <leader>r)
vim.keymap.set("n", "<leader>r", ReloadWindow, { desc = "Reload Window" })

vim.cmd([[
  highlight NvimTreeGitDirty guifg=#E5C07B  " Yellow for modified
  " highlight NvimTreeGitNew guifg=#98C379     " Green for staged/added
  " highlight NvimTreeGitDeleted guifg=#E06C75 " Red for deleted
  " highlight NvimTreeGitIgnored guifg=#5C6370 " Grey for ignored
]])
