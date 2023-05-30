local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("Cannot find telescope!")
  return
end

local actions = require "telescope.actions"

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "truncate" }, -- in the old lunarvim config, this was set to "smart"
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".git/", "node_modules", ".stubs/" },
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        prompt_position = "top",
        mirror = true,
      }
    },
    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      }
    }
  }
})

-- Enable telescope fzf native, if installed
telescope.load_extension("fzf")
vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number" -- set line numbers in the telescope window
