return {
	"lukas-reineke/indent-blankline.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>ib", "<cmd>IndentBlanklineToggle<CR>", desc = "Toggle indenting blank lines" },
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
	end,
}
