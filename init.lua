-- recommended by lazy docs:
--- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw at the very start of your init.lua
-- recommended by nvim-tree docs
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("user.plugins-setup")
require("user.core.options")
require("user.core.keymaps")
require("user.plugins.comment")
require("user.plugins.nvim-tree")
require("user.plugins.lualine")
require("user.plugins.telescope")
require("user.plugins.nvim-cmp")
require("user.plugins.lsp.mason")
require("user.plugins.lsp.lspsaga")
require("user.plugins.lsp.lspconfig")
require("user.plugins.lsp.null-ls")
require("user.plugins.autopairs")
require("user.plugins.treesitter")
require("user.plugins.gitsigns")
require("user.plugins.bufferline")
