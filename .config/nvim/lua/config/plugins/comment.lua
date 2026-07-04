return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")
		local api = require("Comment.api")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		comment.setup({
			mappings = {
				basic = false,
				extra = false,
			},
			sticky = true,
			padding = true,
			-- for commenting tsx, jsx, svelte, html files
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})

		vim.keymap.set("n", "<C-_>", function()
			-- If count is provided (e.g., 3<C-_>), comment that many lines
			if vim.v.count > 0 then
				api.toggle.linewise.count(vim.v.count)
			else
				api.toggle.linewise.current()
			end
		end, { desc = "Toggle line comment" })

		-- Visual mode: Toggle selected region
		vim.keymap.set("x", "<C-_>", function()
			-- Exit visual mode and comment the selection
			local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
			vim.api.nvim_feedkeys(esc, "nx", false)
			api.toggle.linewise(vim.fn.visualmode())
		end, { desc = "Toggle line comment (visual)" })
	end,
}
