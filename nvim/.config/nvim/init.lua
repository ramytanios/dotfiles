-- ------------------------------------------------------
-- INSPIRED by https://github.com/nvim-lua/kickstart.nvim
-- ------------------------------------------------------

vim.g.mapleader = " " -- space leader keymap

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
	"tpope/vim-eunuch",
	"tpope/vim-fugitive",
	"scalameta/nvim-metals",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	"hrsh7th/cmp-nvim-lsp",
	"onsails/lspkind.nvim",
	"christoomey/vim-tmux-navigator",
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{
		"sindrets/diffview.nvim",
	},
	{ "axkirillov/easypick.nvim" },
	{
		"nvim-lualine/lualine.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"xiyaowong/telescope-emoji.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				auto_install = true,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({ numhl = true, linehl = true })
		end,
	},
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				keymaps = { ["<CR>"] = "actions.select" },
				use_default_keymaps = false,
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name, _)
						return name == ".."
					end,
				},
			})
		end,
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"mfussenegger/nvim-lint",
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
		end,
	},
})

-- LUALINE
require("lualine").setup({
	{ options = { theme = "tokyonight" } },
})
require("tokyonight").setup({
	on_highlights = function(hl, c)
		local prompt = "#2d3149"
		hl.TelescopeNormal = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = prompt,
		}
		hl.TelescopePromptBorder = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePromptTitle = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
	end,
})
-- TELESCOPE CONFIGURATION
local telescope = require("telescope")
local ta = require("telescope.actions")
telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		mappings = {
			i = {
				["<C-k>"] = ta.move_selection_previous,
				["<C-j>"] = ta.move_selection_next,
				["<C-q>"] = ta.send_selected_to_qflist + ta.open_qflist,
			},
		},
	},
})
telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("emoji")

-- TELESCOPE PICKERS
local easypick = require("easypick")
easypick.setup({
	pickers = {
		{
			name = "ls",
			command = "ls",
			previewer = easypick.previewers.default(),
		},
	},
})

-- LSP BORDERS
local _border = "single"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})
vim.diagnostic.config({
	float = { border = _border },
})

-- NVIM METALS
local api = vim.api
local metals_config = require("metals").bare_config()
metals_config.settings = {
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})

-- CMP
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
require("luasnip/loaders/from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), --previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), --next suggestion
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	formatting = {
		format = lspkind.cmp_format({ maxwidth = 50, ellipsis_char = "..." }),
	},
})

-- MASON / LSP
local servers = {
	clangd = {},
	pyright = {},
	tsserver = {},
	bashls = {},
	jsonls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- lua setup!
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- Special setup for smithy-language-server
-- One could also bootstrap the language server
-- cs bootstrap software.amazon.smithy:smithy-language-server:0.2.3 -o smithy-language-server
-- add it to the path and require("lspconfig").smithy_ls.setup({})
-- as it will look by default in PATH to an executable smithy-language-server
require("lspconfig").smithy_ls.setup({
	cmd = { "cs", "launch", "software.amazon.smithy:smithy-language-server:latest.stable", "--", "0" },
})

-- LINTING
local lint = require("lint")
lint.linters_by_ft = {
	python = { "pylint" },
	cpp = { "cpplint" },
	typescript = { "eslint_d" },
	javascript = { "eslint_d" },
}
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

-- FORMATTING
require("conform").setup({
	formatters_by_ft = {
		python = { "black" },
		cpp = { "clang_format" },
		lua = { "stylua" },
		bash = { "shfmt" },
		typescript = { "prettier" },
		javascript = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		xml = { "xmlformatter" },
	},
	-- format_on_save = {
	-- 	lsp_fallback = true,
	-- 	async = false,
	-- 	timeout_ms = 1000,
	-- },
})

-- KEYMAPS
local keymap = vim.keymap -- for conciseness
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "x", '"_x')
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "fo", ":join<CR>")
keymap.set("n", "<leader>cf", "<cmd>edit $MYVIMRC<CR>")

keymap.set("n", "<leader>tr", function()
	require("nvim-tree.api").tree.toggle()
end)

-- windows plit
keymap.set("n", "<leader>noh", ":nohl<CR>") -- example /keymap and then clear highlight
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>ss", "<C-w>s") -- slit window horizontal
keymap.set("n", "<leader>se", "<C-w>=") -- make split equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split

keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>")
keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>")
keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>")
keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>")
keymap.set("n", "<leader>d", "<cmd>TroubleToggle lsp_definitions<cr>")
keymap.set("n", "<leader>r", "<cmd>TroubleToggle lsp_references<cr>")
keymap.set("n", "<leader>tn", function()
	require("trouble").next({ skip_groups = true, jump = true })
end)
keymap.set("n", "<leader>tp", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end)
keymap.set("n", "<leader>h", vim.lsp.buf.hover)
keymap.set("n", "<leader>i", vim.lsp.buf.implementation)
keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol)
keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol)
keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
keymap.set("n", "<leader>f", function()
	require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 3000 })
end)
keymap.set("n", "<leader>a", vim.lsp.buf.code_action)

-- gitsigns
local gitsigns = require("gitsigns")
keymap.set("n", "<leader>nh", gitsigns.next_hunk)
keymap.set("n", "<leader>ph", gitsigns.preview_hunk)
keymap.set("n", "<leader>prh", gitsigns.prev_hunk)
keymap.set("n", "<leader>rh", gitsigns.reset_hunk)
keymap.set("n", "<leader>gh", gitsigns.select_hunk)
keymap.set("n", "<leader>lb", gitsigns.toggle_current_line_blame)

-- telescope
local tb = require("telescope.builtin")
keymap.set("n", "<leader>?", tb.oldfiles)
keymap.set("n", "<leader>ff", tb.find_files)
keymap.set("n", "<leader>lg", tb.live_grep)
keymap.set("n", "<leader>gr", tb.grep_string)
keymap.set("n", "<leader>fb", tb.buffers)
keymap.set("n", "<leader>ht", tb.help_tags)
keymap.set("n", "<leader>fda", tb.diagnostics)
keymap.set("n", "<leader>gc", tb.git_commits)
keymap.set("n", "<leader>gb", tb.git_branches)
keymap.set("n", "<leader>gs", tb.git_status)
keymap.set("n", "<leader>co", tb.commands)
keymap.set("n", "<leader>ts", tb.treesitter)
keymap.set("n", "<leader>gf", tb.git_files)
keymap.set("n", "<leader>mc", require("telescope").extensions.metals.commands)
keymap.set("n", "<leader>cs", function()
	tb.colorscheme({ enable_preview = true })
end)
vim.api.nvim_set_keymap("n", "<leader>bb", ":Telescope file_browser<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>em", ":Telescope emoji<CR>", { noremap = true })

-- diagnostic in a float
keymap.set("n", "<leader>fd", function()
	vim.diagnostic.open_float()
end)

-- todo
keymap.set("n", "<leader>to", "<cmd>TodoTelescope<cr>", { silent = true, noremap = true })

-- oil nvim
keymap.set("n", "-", require("oil").open)

-- diff view
vim.api.nvim_set_keymap("n", "<leader>dv", ":DiffviewOpen<SPACE>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dvx", ":DiffviewClose<CR>", { noremap = true })

-- VIM OPTIONS
local opt = vim.opt -- for conciseness
-- line numbers
opt.relativenumber = true
opt.number = true
-- use Xj to navigate relatively
-- tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
-- line wrapping
opt.wrap = false
-- search settings
opt.ignorecase = true
opt.smartcase = true
-- cursor line
opt.cursorline = true
-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
-- backspace
opt.backspace = "indent,eol,start"
-- clipboard
opt.clipboard:append("unnamedplus")
-- split windows
opt.splitright = true -- vertical split
opt.splitbelow = true -- horizontal split
opt.swapfile = false

vim.cmd("colorscheme tokyonight-storm")
