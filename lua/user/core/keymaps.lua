-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- Not needed if using the christoomey/vim-tmux-navigator plugin
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Center when using ctrl d and u
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bp|bd #<CR>", opts)

-- Clear highlights
keymap("n", "<leader>c", "<cmd>nohlsearch<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)
keymap("n", "x", '"_x', opts) -- x will no longer write to a register

-- Keep cursor in the middle when searching
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Easy search and replace setup for the word the cursor is on
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

keymap("n", "Q", "<nop>") -- disables Q

-- Prevent accidentally hitting q all the time in normal mode and starting a recording...
keymap("n", "<leader>q", "q", opts)
keymap("n", "q", "<Nop>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move visual line selected lines up and down
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '>-2<CR>gv=gv")

-- Insert --
keymap("i", "<C-c>", "<ESC>")

-- Command --
-- Handling common typos
keymap("c", "Wa", "wa")
keymap("c", "W", "w")
keymap("c", "Qa", "qa")
keymap("c", "Q", "q")

-- Plugins keymaps --

-- EXPERIMENTAL
-- Trying these out...
keymap("n", "<leader>+", "<C-a>", opts) -- increment shortcut
keymap("n", "<leader>-", "<C-x>", opts) -- decrement shortcut
-- Commenting these out as they will conflict with the new harpoon keymaps
-- keymap("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
-- keymap("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
-- keymap("n", "<leader>tn", ":tabn<CR>", opts) -- go to next tab
-- keymap("n", "<leader>tp", ":tabp<CR>", opts) -- go to previous tab

-- Tmux sessionizer
keymap("n", "<C-f>", ":silent !tmux neww ~/.config/tmux/tmux-sessionizer<CR>")
