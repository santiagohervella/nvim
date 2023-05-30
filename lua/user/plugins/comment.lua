local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	print("Comment plugin not found!")
	return
end

local commentstring_status_ok, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if not commentstring_status_ok then
	print("Cannot find ts_context_commentstring.integrations.comment_nvim plugin!")
	return
end

comment.setup({
	-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
	prehook = commentstring.create_pre_hook(),
	toggler = {
		line = "<leader>/",
	},
	opleader = {
		line = "<leader>/",
	},
})

-- TODO: Review the old lunarvim config for this in case there's good stuff in there
