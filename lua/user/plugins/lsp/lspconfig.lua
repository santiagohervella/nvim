local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	print("Cannot find lspconfig!")
	return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
	print("Cannot find cmp_nvim_lsp!")
	return
end

local typescript_status_ok, typescript = pcall(require, "typescript")
if not typescript_status_ok then
	print("Cannot find typescript!")
	return
end

local keymap = vim.keymap

-- enable keybinds for available lsp server
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	-- There are so many more to explore in the Lspsaga dacumentation: https://github.com/nvimdev/lspsaga.nvim
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	-- TODO: See if you like this peek shit. If you don't, use the old way instead:
	-- keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- go to references
	keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	-- keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts) -- old lunarvim one
	keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	-- keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts) -- old lunarvim one
	-- TODO: See if you like this Lspsaga one. If you don't, use the old way instead:
	-- keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- show line diagnostics
	keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show diagnostics for line

	-- TODO: Try this out, no clue what it does:
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor

	keymap.set("n", "<leader>gs", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts) -- show buffer diagnostics
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	-- for reference, here are the equivalent keymaps from the old lunarvim config
	keymap.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap.set("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	-- TODO: See if you like this Lspsaga one. If you don't, use the old way instead:
	-- keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts) -- from old lunarvim config. I updated it for nvim 0.8+
	keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts) -- from old lunarvim config
	keymap.set("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts) -- from old lunarvim config
	-- I never used these next two in the old lunarvim config, but I figured it doesn't hurt to bring them over
	keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- from old lunarvim config
	keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) -- from old lunarvim config

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- TODO: See how I feel about having these at all
-- change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
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
