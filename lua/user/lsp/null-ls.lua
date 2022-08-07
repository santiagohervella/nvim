local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- part of the autosave logic, which I got from the documentation here: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
			extra_filetypes = { "toml" },
			extra_args = { "--single-quote" },
		}),
		-- formatting.isort.with({
		-- 	extra_args = { "-l", "120" },
		-- }),
		formatting.black.with({ extra_args = { "--fast", "-l", "120" } }),

		-- https://githubhot.com/repo/sumneko/lua-language-server/issues/1035
		-- formatting.black.with {
		--   condition = function(utils)
		--     return utils.root_has_file { 'setup.py', 'setup.cfg', 'pyproject.toml' }
		--   end,
		-- },

		formatting.stylua,
		formatting.google_java_format,
		diagnostics.flake8.with({
			prefer_local = ".venv/bin", -- This is so that flake8 prefers the python in the .venv of the open project
		}),
		formatting.terraformls,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
