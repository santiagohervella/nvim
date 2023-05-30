local lspsaga_status, lspsaga = pcall(require, "lspsaga")
if not lspsaga_status then
	print("Cannot find lspsaga")
	return
end

lspsaga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
	-- use enter to open file with definition preview
	definition = {
		edit = "<CR>",
		quit = { "q", "<ESC>" },
	},
	-- TODO: Uncomment this if you get annoyed by the inline lightbulb
	lightbulb = {
		enable = false,
		enable_in_insert = false,
	},
	code_action = {
		-- these are all defaults
		num_shortcut = true,
		show_server_name = false,
		extend_gitsigns = true,
		keys = {
			-- this quit is the only thing I changed (I added escape)
			quit = { "q", "<ESC>" },
			exec = "<CR>",
		},
	},
	symbol_in_winbar = {
		enable = false, -- this puts file breadcrubs at the top of the buffer
	},
	-- ui = {
	--   colors = {
	--     normal_bg = "#022746",
	--   },
	-- },
})
