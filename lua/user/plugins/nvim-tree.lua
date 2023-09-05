return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvim_tree = require("nvim-tree")

		-- TODO: Many symbol settings in old lunarvim setup to look at
		nvim_tree.setup({
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			renderer = {
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			view = {
				width = 50,
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
		})

		-- Shorten function name
		local keymap = vim.keymap.set
		-- Silent keymap option
		local opts = { silent = true, desc = "Show nvim-tree" }

		keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
	end,
}
