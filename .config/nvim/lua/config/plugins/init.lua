-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

--- Set Leader Key
vim.g.mapleader = " "

--- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "config.plugins.render-markdown" },
		{ import = "config.plugins.guess-indent" },
		{ import = "config.plugins.tokyo_night" },
		{ import = "config.plugins.kanagawa" },
		{ import = "config.plugins.nvim-treesitter" },
		{ import = "config.plugins.vim_tmux_navigator" },
		{ import = "config.plugins.fzf-lua" },
		{ import = "config.plugins.project" },
		{ import = "config.plugins.lsp" },
		{ import = "config.plugins.conform" },
		{ import = "config.plugins.blink-cmp" },
		{ import = "config.plugins.blink-pairs" },
		{ import = "config.plugins.nvim_tree" },
		{ import = "config.plugins.whichkey" },
		{ import = "config.plugins.alpha" },
		{ import = "config.plugins.auto_session" },
		{ import = "config.plugins.bufferline" },
		{ import = "config.plugins.lualine" },
		{ import = "config.plugins.dressing" },
		{ import = "config.plugins.vim_maximizer" },
		{ import = "config.plugins.indent_blankline" },
		{ import = "config.plugins.comment" },
		{ import = "config.plugins.todo_comments" },
		{ import = "config.plugins.substitute" },
		{ import = "config.plugins.nvim_surround" },
		{ import = "config.plugins.trouble" },
		{ import = "config.plugins.nvim_lint" },
		{ import = "config.plugins.gitsigns" },
		{ import = "config.plugins.diffview" },
		{ import = "config.plugins.lazygit" },
	},
	-- Configure any other settings here. See the documentation for more details.
	defaults = {
		lazy = false,
	},
	checker = {
		enable = true,
		notify = true,
	},
	change_detection = {
		notify = false,
	},
	-- colorscheme that will be used when installing plugins.
	install = {
		missing = true,
		colorscheme = { "tokyonight" },
	},
})
