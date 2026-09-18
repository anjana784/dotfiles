-- fzf-lua setup.
--
-- Two things are easy to get wrong here, both of which bit us on the
-- vigor-omni monorepo (bun + turbo, ~107k files under node_modules/.bun):
--
--  1. `rg_opts`/`fd_opts` are STRINGS. fzf-lua merges user opts with
--     `vim.tbl_deep_extend("force", ...)`, so overriding one REPLACES the
--     stock value instead of extending it. Dropping the stock grep flags
--     silently breaks result parsing (entries render as bare text, and the
--     preview tries to `stat` a directory) and fzf-lua warns
--     "Added missing '--line-number' flag to 'rg'" on every run.
--
--  2. `file_ignore_patterns` is NOT an exclusion mechanism. fzf-lua applies
--     it in `make_entry.file` as a post-hoc display filter, after the file
--     traversal has already produced every path. It cannot prune the walk,
--     so use real provider globs (`-g` / `--exclude`) and let gitignore do
--     the rest.
--
-- The excluded dirs below are already covered by the repo's .gitignore, but
-- ripgrep only honours .gitignore when it detects a git repo, so we exclude
-- them explicitly to stay correct outside one.

local EXCLUDED = {
	".git",
	".jj",
	"node_modules",
	".turbo",
	".next",
	"dist",
	"out",
	"coverage",
	".bun-cache",
}

-- ripgrep uses `-g "!<glob>"`.
local rg_excludes = {}
for _, dir in ipairs(EXCLUDED) do
	rg_excludes[#rg_excludes + 1] = ('-g "!%s"'):format(dir)
end
rg_excludes = table.concat(rg_excludes, " ")

-- fd uses `--exclude <name>`.
local fd_excludes = {}
for _, dir in ipairs(EXCLUDED) do
	fd_excludes[#fd_excludes + 1] = "--exclude " .. dir
end
fd_excludes = table.concat(fd_excludes, " ")

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		files = {
			-- Keep dotfiles (.gitignore, .nvmrc, .prettierrc, .husky/*) visible.
			-- fzf-lua defaults this to true and appends `--hidden` for us.
			hidden = true,

			-- Used when `fd` is installed (preferred provider).
			fd_opts = "--color=never --type f --type l " .. fd_excludes,

			-- Used when only `rg` is available.
			-- `--no-require-git` makes ripgrep honour .gitignore even outside a
			-- git repo -- without it, opening nvim in $HOME dumps ~2M paths.
			rg_opts = "--color=never --files --no-require-git " .. rg_excludes,
		},
		grep = {
			hidden = true,

			-- Keep fzf-lua's stock flag set intact (see note 1 above) and append
			-- our globs. `-e` must stay LAST: fzf-lua's `rg_insert_args` locates
			-- it to splice in `--with-filename` and the query.
			rg_opts = table.concat({
				"--column",
				"--line-number",
				"--no-heading",
				"--color=always",
				"--smart-case",
				"--max-columns=4096",
				rg_excludes,
				"-e",
			}, " "),
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find files in project directory",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Find by grepping project directory",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find files in Neovim config directory",
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "Find recently opened files",
		},
	},
}
