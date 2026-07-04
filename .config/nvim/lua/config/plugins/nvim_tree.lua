return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		local function custom_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "n", api.fs.create, opts("Create"))
			vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
			vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
			vim.keymap.set("n", "D", api.fs.remove, opts("Delete Permenently"))
			vim.keymap.set("n", "d", api.fs.trash, opts("Delete"))
			vim.keymap.set("n", "r", api.fs.rename_node, opts("Rename node"))
			vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
			vim.keymap.set("n", "rb", api.fs.rename_basename, opts("Rename Basename"))
			vim.keymap.set("n", "rs", api.fs.rename_sub, opts("Rename Sub"))
			vim.keymap.set("n", "rf", api.fs.rename_full, opts("Rename Full"))
			vim.keymap.set("n", "ya", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			vim.keymap.set("n", "yb", api.fs.copy.basename, opts("Copy Basename"))
			vim.keymap.set("n", "yn", api.fs.copy.filename, opts("Copy Filename"))
			vim.keymap.set("n", "yr", api.fs.copy.relative_path, opts("Copy Relative Path"))
			vim.keymap.set("n", "cc", api.fs.clear_clipboard, opts("Clear Clipboard"))
			vim.keymap.set("n", "cp", api.fs.print_clipboard, opts("Print Clipboard"))
		end

		nvimtree.setup({
			on_attach = custom_on_attach,
			view = {
				width = 35,
				relativenumber = true,
			},
			hijack_cursor = true,
			-- git
			git = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
				disable_for_dirs = {},
				timeout = 400,
				cygwin_support = false,
			},
			-- diagnostics
			diagnostics = {
				enable = true,
				debounce_delay = 500,
				show_on_dirs = true,
				show_on_open_dirs = true,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			-- modified
			modified = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			-- change folder arrow icons
			renderer = {
				root_folder_label = ":t",
				decorators = { "Modified", "Git", "Open", "Cut", "Hidden", "Diagnostics" },
				highlight_git = "all",
				highlight_diagnostics = "all",
				highlight_opened_files = "all",
				highlight_modified = "all",
				indent_markers = {
					enable = true,
				},
				icons = {
					git_placement = "after",
					glyphs = {
						git = {
							unstaged = "󰫺",
							untracked = "󰬂",
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				git_ignored = false,
				custom = { ".DS_Store" },
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
