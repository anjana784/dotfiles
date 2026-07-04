return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim", -- automatic_enable = true by default (auto vim.lsp.enable)
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		-- ── Global LSP capabilities via blink.cmp ────────────────────────
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		-- ── Per-server overrides (only servers needing non-default settings) ──
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		-- ── LspAttach: keymaps, document highlighting, inlay hints ──────
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("cr", vim.lsp.buf.rename, "[R]e[n]ame")
				map("ca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
				map("grr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
				map("gri", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
				map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gO", require("fzf-lua").lsp_document_symbols, "Open Document Symbols")
				map("gW", require("fzf-lua").lsp_live_workspace_symbols, "Open Workspace Symbols")
				map("grt", require("fzf-lua").lsp_typedefs, "[G]oto [T]ype Definition")

				-- Document highlight on cursor hold
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "user-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- Inlay hints toggle
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- ── Diagnostic display ──────────────────────────────────────────
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					return diagnostic.message
				end,
			},
		})

		-- ── Install tools via Mason (LSP servers + formatters) ──────────
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP servers
				"lua-language-server",
				"typescript-language-server",
				"html-lsp",
				"css-lsp",
				"tailwindcss-language-server",
				"json-lsp",
				"prisma-language-server",
				"clangd",
				"eslint-lsp",
				-- Formatters
				"stylua",
				"prettierd",
				"prettier",
				"isort",
				"black",
				-- Linters
				"eslint_d",
			},
		})

		-- ── Auto-enable installed LSP servers (default automatic_enable = true) ──
		require("mason-lspconfig").setup({})
	end,
}
