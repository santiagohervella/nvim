return {
	"lukas-reineke/indent-blankline.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local indent_blankline = require("indent_blankline")

		indent_blankline.setup({
			enabled = false,
			char = "▏",
			show_trailing_blankline_indent = false,
			show_first_indent_level = true,
			use_treesitter = true,
			show_current_context = true,
			buftype_exclude = { "terminal", "nofile" },
			filetype_exclude = {
				"help",
				"packer",
				"NvimTree",
			},
		})

		-- Shorten function name
		local keymap = vim.keymap.set

		-- Toggle the plugin
		keymap("n", "<leader>ib", "<cmd>IndentBlanklineToggle<CR>")
	end,
}
