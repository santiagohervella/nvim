return {
	"szw/vim-maximizer",
	-- Lazy load plugin when keymap is triggered
	keys = {
		{ "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
	},
}
