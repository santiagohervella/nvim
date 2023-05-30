-- This is the default recommended setup in the readme for lazy.nvim
-- https://github.com/folke/lazy.nvim

--- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- the colorscheme should be available when starting Neovim so let's do that first
	{
		"folke/tokyonight.nvim",
		--lazy = false, -- make sure we load this during startup if it is your main colorscheme
		--priority = 1000, -- make sure to load this before all the other start plugins
		--config = function()
		--	-- load the colorscheme here
		--	vim.cmd([[colorscheme tokyonight]])
		--end,
	},
	{
		-- Again, not too shabby, but the green is too much and too much contrast
		"EdenEast/nightfox.nvim",
		--lazy = false, -- make sure we load this during startup if it is your main colorscheme
		--priority = 1000, -- make sure to load this before all the other start plugins
		--config = function()
		--	-- load the colorscheme here
		--	vim.cmd([[colorscheme carbonfox]])
		--end,
	},
	{
		"marko-cerovac/material.nvim",
		--lazy = false, -- make sure we load this during startup if it is your main colorscheme
		--priority = 1000, -- make sure to load this before all the other start plugins
		--config = function()
		--	-- load the colorscheme here
		--	-- Not too bad
		--	-- vim.g.material_style = "darker"
		--	-- I like this one, but the contrast is just a bit too high
		--	vim.g.material_style = "deep ocean"
		--	vim.cmd([[colorscheme material]])
		--end,
	},
	{
		-- This one is pretty good, but suffers again from just too much orange
		"sainnhe/sonokai",
		--lazy = false, -- make sure we load this during startup if it is your main colorscheme
		--priority = 1000, -- make sure to load this before all the other start plugins
		--config = function()
		--	-- load the colorscheme here
		--	vim.g.sonokai_style = "espresso"
		--	vim.cmd([[colorscheme sonokai]])
		--end,
	},
	{
		-- I don't love this one as much as I used to. I like the tint, but don't love the orange
		-- "ellisonleao/gruvbox.nvim",
		-- This version of gruvbox is better because the shitty orange is gone
		--"luisiacc/gruvbox-baby",
		-- Damn, I think I like this one with a hint of orange the best
		"sainnhe/gruvbox-material",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_better_performance = 1
			-- load the colorscheme here
			vim.cmd([[colorscheme gruvbox-material]])
			-- vim.cmd([[colorscheme gruvbox-baby]])
		end,
	},
	--{
	--	-- https://github.com/rebelot/kanagawa.nvim
	--  -- Too much yellow, I don't love this one...
	--  -- On second thought, this one is not bad
	--	"rebelot/kanagawa.nvim",
	--	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--	priority = 1000, -- make sure to load this before all the other start plugins
	--	config = function()
	--		-- load the colorscheme here
	--		vim.cmd([[colorscheme kanagawa-dragon]])
	--	end,
	--},
	--{
	--  -- Custom catppuccin/nvim
	--  -- https://github.com/nullchilly/CatNvim/blob/bea18b53958627aff3051c22591a4f5771a882c8/lua/plugins/colorscheme.lua#L24-L30
	--	"catppuccin/nvim",
	--	name = "catppuccin",
	--	lazy = false,
	--	priority = 1000,
	--	config = function()
	--		require("catppuccin").setup({
	--			flavour = "mocha", -- latte, frappe, macchiato, mocha
	--			term_colors = true,
	--			transparent_background = false,
	--			no_italic = false,
	--			no_bold = false,
	--			styles = {
	--				comments = {},
	--				conditionals = {},
	--				loops = {},
	--				functions = {},
	--				keywords = {},
	--				strings = {},
	--				variables = {},
	--				numbers = {},
	--				booleans = {},
	--				properties = {},
	--				types = {},
	--			},
	--			color_overrides = {
	--				mocha = {
	--					base = "#000000",
	--					mantle = "#000000",
	--					crust = "#000000",
	--				},
	--			},
	--			highlight_overrides = {
	--				mocha = function(C)
	--					return {
	--						TabLineSel = { bg = C.pink },
	--						CmpBorder = { fg = C.surface2 },
	--						Pmenu = { bg = C.none },
	--						TelescopeBorder = { link = "FloatBorder" },
	--					}
	--				end,
	--			},
	--		})
	--
	--		vim.cmd.colorscheme("catppuccin")
	--	end,
	--},
	{
		"nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
	},
	-- Fuzzy Finder (files, lsp, etc)
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{ "nvim-tree/nvim-tree.lua" }, -- file explorer
	{ "nvim-tree/nvim-web-devicons" }, -- a bunch of icons auto-set for nvim-tree
	{ "nvim-lualine/lualine.nvim" }, -- status line
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" }, -- buffer line aka tab title thing
	{ "szw/vim-maximizer" }, -- maximizes and restores current window
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },

	-- cmp plugins aka autocompletion
	{ "hrsh7th/nvim-cmp" }, -- completion plugin
	{ "hrsh7th/cmp-buffer" }, -- source for text in buffer
	{ "hrsh7th/cmp-path" }, -- source for file system paths

	-- snippets for cmp
	{ "L3MON4D3/LuaSnip" }, -- snippet engine
	{
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "rafamadriz/friendly-snippets" }, -- useful snippets

	-- managing & installing lsp servers
	{ "williamboman/mason.nvim" }, -- in charge of managing lsp servers, linters & formatters
	{ "williamboman/mason-lspconfig.nvim" }, -- bridges gap between mason & lspconfig

	-- configuring lsp servers
	{ "neovim/nvim-lspconfig" }, -- easily configure language servers
	{ "hrsh7th/cmp-nvim-lsp" }, -- for autocompletion
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}, -- enhanced lsp UIs
	{ "jose-elias-alvarez/typescript.nvim" }, -- additional functionality for typescript server (rename files & update imports, etc)

	-- formatting & linting
	{ "jose-elias-alvarez/null-ls.nvim" }, --configure formatters & linters
	{ "jayp0521/mason-null-ls.nvim" }, -- bridges gap between mason & null-ls

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},

	-- auto closing
	{ "windwp/nvim-autopairs" },
	{ "windwp/nvim-ts-autotag" },

	-- show local git changes
	{ "lewis6991/gitsigns.nvim" },
	{ "RRethy/vim-illuminate" }, -- highlights other uses of the word under the cursor. Requires no setup

	-- TODO: See if you want this
	-- {
	--   "christoomey/vim-tmux-navigator"
	-- }
}, {})
