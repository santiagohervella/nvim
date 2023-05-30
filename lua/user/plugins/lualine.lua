local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  print("Cannot find lualine!")
  return
end

local location = {
  "location",
  padding = 0,
}

lualine.setup({
  options = {
    icons_enabled = false,
    theme = "nightfly",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
   lualine_a = { "mode" },
   lualine_b = { "branch" },
   lualine_c = { "diff" },
   lualine_x = { "filetype" },
   lualine_y = { "progress" },
   lualine_z = { location },
  }
})
