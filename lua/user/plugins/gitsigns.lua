return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
	keys = {
		{ "<leader>gp", "<cmd>:Gitsigns preview_hunk<CR>", desc = "Toggle git hunk preview" },
		{ "<leader>rh", "<cmd>:Gitsigns reset_hunk<CR>", desc = "Reset hunk under the cursor" },
	},
}
