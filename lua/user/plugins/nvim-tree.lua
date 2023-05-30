local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	print("Cannot find nvim-tree!")
	return
end

-- TODO: Many symbol settings in old lunarvim setup to look at
nvim_tree.setup({
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},
})
