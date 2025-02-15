return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		gitbrowse = { enabled = true },
		indent = {
			enabled = true,
			animate = {
				enabled = false,
			},
			chunk = {
				enabled = true,
			},
		},
		bigfile = {
			enabled = true,
		},
	},
	keys = {
		{
			"<leader>gw",
			"<cmd>lua require('snacks').gitbrowse()<CR>",
			desc = "Open current file in the browser",
		},
		{
			"<leader>ib",
			function()
				local snacks = require("snacks")
				if snacks.indent.enabled then
					snacks.indent.disable()
				else
					snacks.indent.enable()
				end
			end,
			desc = "Toggle indenting blank lines",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages for anything in your nvim config",
		},
	},
}
