return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"jose-elias-alvarez/typescript.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{
			"smjonas/inc-rename.nvim",
			config = true,
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local typescript = require("typescript")

		local keymap = vim.keymap -- for conciseness

		-- enable keybinds only for when lsp server available
		local on_attach = function(client, bufnr)
			-- keybind options
			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			-- Prefer the Telescope version? ^^^
			-- opts.desc = "Show references"
			-- keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- go to references

			-- Deciding not to use this one for now because `:h declaration` tell us: "Note: Many servers do not implement this method. Generally, see
			-- |vim.lsp.buf.definition()| instead."
			-- opts.desc = "Go to declaration"
			-- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Go to definition in vertical split"
			keymap.set("n", "gD", ":vsplit | lua vim.lsp.buf.definition()<CR>")

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Format buffer"
			keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

			-- TODO: What exactly does this do?
			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>lr", ":IncRename ", opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file

			opts.desc = "Show workspace diagnostics"
			keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", opts) -- show diagnostics for workspace

			opts.desc = "Show registers"
			keymap.set("n", "<leader>rr", "<cmd>Telescope registers<CR>", opts) -- show registers

			opts.desc = "Show line diagnostics"
			keymap.set("n", "gl", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			-- typescript specific keymaps (e.g. rename file and update imports)
			if client.name == "tsserver" then
				opts.desc = "Rename file and update file imports"
				keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports

				opts.desc = "Organize imports"
				keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", opts) -- organize imports (not in youtube nvim video)

				opts.desc = "Remove unused imports"
				keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>", opts) -- remove unused variables (not in youtube nvim video)
			end
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- TODO: See how I feel about having these at all
		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Setup servers
		local servers = require("mason-lspconfig").get_installed_servers()

		for _, server in pairs(servers) do
			if server == "typescript" then
				-- configure typescript server with plugin
				typescript.setup({
					server = {
						capabilities = capabilities,
						on_attach = on_attach,
					},
				})
			elseif server == "pyright" then
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = { "python" },
				})
			elseif server == "lua_ls" then
				-- configure lua server (with special settings)
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						-- custom settings for lua
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								-- make language server aware of runtime files
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				})
			else
				-- Default lsp setup
				lspconfig[server].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
		end
	end,
}
