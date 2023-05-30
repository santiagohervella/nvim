local autopairs_status_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_status_ok then
	print("Cannot find autopairs!")
	return
end

-- configure autopairs
autopairs.setup({
	check_ts = true, -- enable treesitter
	ts_config = {
		lua = { "string" }, -- don't add pairs in lua string treesitter nodes
		javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
		java = false, -- don't check treesitter on java
	},
})

-- import nvim-autopairs completion functionality safely
local cpm_autopairs_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cpm_autopairs_status_ok then
	print("Cannot find nvim-autopairs.completion.cmp!")
	return
end

-- import nvim-cmp plugin safely (completions plugin)
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	print("Cannot find cmp!")
	return
end

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
