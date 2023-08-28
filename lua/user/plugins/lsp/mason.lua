return {
	-- in charge of managing lsp servers, linters & formatters
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim", -- bridges gap between mason & lspconfig
		"jayp0521/mason-null-ls.nvim", -- bridges gap between mason & null-ls
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_null_ls = require("mason-null-ls")

		-- enable mason
		mason.setup()

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_null_ls.setup({
			-- list of formatters & linters for mason to install
			ensure_installed = {
				"prettier", -- ts/js formatter
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true,
		})
	end,
}
