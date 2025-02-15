return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		gitbrowse = { enabled = true },
	},
	keys = {
		{
			"<leader>gw",
			"<cmd>lua require('snacks').gitbrowse()<CR>",
			desc = "Open current file in the browser",
		},
		-- Using telescope-helpgrep instead. Check out ./telescope-helpgrep.lua
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages for anything in your nvim config",
		},
	},
}
