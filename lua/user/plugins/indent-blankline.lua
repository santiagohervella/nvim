-- Old v2 setup
-- return {
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	dependencies = {
-- 		"nvim-treesitter/nvim-treesitter",
-- 	},
-- 	keys = {
-- 		{ "<leader>ib", "<cmd>IndentBlanklineToggle<CR>", desc = "Toggle indenting blank lines" },
-- 	},
-- 	config = function()
-- 		local indent_blankline = require("indent_blankline")
--
-- 		indent_blankline.setup({
-- 			enabled = false,
-- 			char = "▏",
-- 			show_trailing_blankline_indent = false,
-- 			show_first_indent_level = true,
-- 			use_treesitter = true,
-- 			show_current_context = true,
-- 			buftype_exclude = { "terminal", "nofile" },
-- 			filetype_exclude = {
-- 				"help",
-- 				"packer",
-- 				"NvimTree",
-- 			},
-- 		})
-- 	end,
-- }

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>ib", "<cmd>IBLToggle<CR>", desc = "Toggle indenting blank lines" },
	},
	config = function()
		-- most of this is from https://github.com/lukas-reineke/indent-blankline.nvim#multiple-indent-colors
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)

		require("ibl").setup({ indent = { highlight = highlight } })
	end,
}
