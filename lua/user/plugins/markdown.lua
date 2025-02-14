-- Found out about this plugin here
-- https://github.com/Wansmer/nvim-config/blob/main/lua/config/plugins/md-renderer.lua
return {
	"MeanderingProgrammer/markdown.nvim",
	enabled = true,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = { "markdown" },
	event = "BufReadPre",
	config = function()
		require("render-markdown").setup({
			file_types = { "markdown", "Avante" },
			anti_conceal = {
				enabled = true, -- show raw md on line under curson
			},
		})
	end,
}
