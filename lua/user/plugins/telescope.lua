return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	-- TODO: Confirm these dependencies with existing setup
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			-- TODO: Is this check still something I should keep?
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
		"ThePrimeagen/harpoon",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local themes = require("telescope.themes")

		-- configure telescope
		telescope.setup({
			-- configure custom mappings
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "truncate" }, -- in the old lunarvim config, this was set to "smart"
				sorting_strategy = "ascending",
				file_ignore_patterns = { ".git/", "node_modules", ".stubs/" },
				-- make the layout like jetbrains global search
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
					},
				},
				mappings = {
					i = {
						["<Down>"] = actions.cycle_history_next,
						["<Up>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					themes.get_dropdown({}),
				},
			},
		})

		-- Enable telescope fzf native, if installed
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("harpoon")

		-- set line numbers in the telescope window
		vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")

		-- Shorten function name
		local keymap = vim.keymap.set

		-- find files within current working directory, respects .gitignore
		keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd", silent = true })
		-- find string in current working directory as you type
		keymap("n", "<leader>ft", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd", silent = true })
		-- find string under cursor in current working directory
		keymap(
			"n",
			"<leader>fc",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "Find string under cursor in cwd", silent = true }
		)
		-- list open buffers in current neovim instance
		keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Show open buffers", silent = true })
		-- show harpoon marks
		keymap("n", "<leader>fh", "<cmd>Telescope harpoon marks<cr>", { desc = "Show harpoon marks" })

		-- TODO: Consider trying these out
		-- list all git commits (use <cr> to checkout) ["gc" for git commits]
		keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" })
		-- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
		keymap("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "Show git commits for current buffer" })
		-- list git branches (use <cr> to checkout) ["gb" for git branch]
		keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" })
		-- list current changes per file with diff preview ["gs" for git status]
		keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show current git changes per file" })
	end,
}
