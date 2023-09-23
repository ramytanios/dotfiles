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
	-- color schemes
	"EdenEast/nightfox.nvim",
	"folke/tokyonight.nvim",
	"rebelot/kanagawa.nvim",
	-- lua functions that many plugins use
	"nvim-lua/plenary.nvim",
	-- tmux and split window navigation
	"christoomey/vim-tmux-navigator",
	-- essential plugins
	"tpope/vim-surround",
	-- commenting with gc
	"numToStr/Comment.nvim",
	-- icons
	"kyazdani42/nvim-web-devicons",
	-- status line
	"nvim-lualine/lualine.nvim",
	-- telescope
	"nvim-telescope/telescope.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	-- autocompletion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	-- snippets
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	-- managing and installing lsp server, linters and formatters
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	-- configure lsp servers
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"onsails/lspkind.nvim",
	-- formatting and linting
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",
	-- treesitter
	"nvim-treesitter/nvim-treesitter",
	"lewis6991/gitsigns.nvim",
	-- metals for scala
	"scalameta/nvim-metals",
	-- oil nvim
	"stevearc/oil.nvim",
	-- nvim netrw icons and stuff
	"prichrd/netrw.nvim",
	-- UNIX like commands for vim
	"tpope/vim-eunuch",
	-- function signature LSP
	"ray-x/lsp_signature.nvim",
	"folke/todo-comments.nvim",
	-- git plugin
	"tpope/vim-fugitive",
	-- telescope ui select
	"nvim-telescope/telescope-ui-select.nvim",
	-- telescope emojies
	"xiyaowong/telescope-emoji.nvim",
	-- trouble nvim
	"folke/trouble.nvim",
	-- leap nvim
	"ggandor/leap.nvim",
	"simrat39/symbols-outline.nvim",
	"karb94/neoscroll.nvim",
})
