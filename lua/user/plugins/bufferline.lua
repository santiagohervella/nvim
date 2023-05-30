local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then
	print("Cannot find bufferline!")
	return
end

bufferline.setup({
	options = {
		show_buffer_close_icons = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "",
				highlight = "Directory",
				separator = true, -- use a "true" to enable the default, or set your own character
			},
		},
	},
})
