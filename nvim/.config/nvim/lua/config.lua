-- ** Comment **
----------------
local setup, comment = pcall(require, "Comment")
if not setup then
	return
end
comment.setup()

-- ** gitsigns **
----------------
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
	return
end
gitsigns.setup()

-- ** leap **
----------------
require("leap").add_default_mappings()

-- ** lualine **
----------------
local status, lualine = pcall(require, "lualine")
if not status then
	return
end
lualine.setup({
	options = {
		theme = "auto",
	},
})

-- ** metals **
----------------
local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set
local metals_config = require("metals").bare_config()
-- Example of settings
metals_config.settings = {
	-- showImplicitArguments = true,
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
	-- NOTE: You may or may not want java included here. You will need it if you
	-- want basic Java support but it may also conflict if you are using
	-- something like nvim-jdtls which also works on a java filetype autocmd.
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})

-- ** neoscroll **
----------------
require("neoscroll").setup()

-- ** nvim cmp **
----------------
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end
-- load friendly snippers
require("luasnip/loaders/from_vscode").lazy_load()
vim.opt.completeopt = "menu,menuone,noselect"
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), --previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), --next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), --close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})

-- ** netrw **
----------------
require("netrw").setup({})

-- ** oil nvim **
----------------
require("oil").setup({
	-- Id is automatically added at the beginning, and name at the end
	-- See :help oil-columns
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	-- Buffer-local options to use for oil buffers
	buf_options = {},
	-- Window-local options to use for oil buffers
	win_options = {
		wrap = false,
		signcolumn = "no",
		cursorcolumn = false,
		foldcolumn = "0",
		spell = false,
		list = false,
		conceallevel = 3,
		concealcursor = "n",
	},
	-- Restore window options to previous values when leaving an oil buffer
	restore_win_options = true,
	-- Skip the confirmation popup for simple operations
	skip_confirm_for_simple_edits = false,
	-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
	-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
	-- Additionally, if it is a string that matches "actions.<name>",
	-- it will use the mapping at require("oil.actions").<name>
	-- Set to `false` to remove a keymap
	-- See :help oil-actions for a list of all available actions
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<os>"] = "actions.select_vsplit",
		["<oh>"] = "actions.select_split",
		["<op>"] = "actions.preview",
		["<oc>"] = "actions.close",
		["<ol>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["g."] = "actions.toggle_hidden",
	},
	-- Set to false to disable all of the above keymaps
	use_default_keymaps = false,
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
	},
	-- Configuration for the floating window in oil.open_float
	float = {
		-- Padding around the floating window
		padding = 2,
		max_width = 0,
		max_height = 0,
		border = "rounded",
		win_options = {
			winblend = 10,
		},
	},
})

-- ** symbols outline **
----------------
require("symbols-outline").setup()

-- ** telescope **
----------------
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end
telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")
telescope.load_extension("emoji")

-- ** todo comments **
----------------
require("todo-comments").setup()

-- ** treesitter **
----------------
-- import nvim-treesitter plugin safely
require("nvim-treesitter.install").prefer_git = true

local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- ensure_installed = {
	--   "scala",
	--   "python",
	--   "json",
	--   "http"
	-- },
	-- automatically install parsers when entering a buffer
	auto_install = true,
	rainbow = {
		enable = true,
	},
})

-- ** trouble **
----------------
require("trouble").setup()

-- ** lsp signature **
----------------
require("lsp_signature").setup()

-- ** mason **
----------------
-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- enable mason
mason.setup({
	registries = {
		"lua:mason-registry.index",
		"github:mason-org/mason-registry@2023-07-05-wry-eel",
	},
})

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"pyright", -- python, uses npm
		"tsserver", -- typescript and javascript uses npm
		"bashls", -- bash uses npm
		"sqlls", -- uses npm
		"jsonls", -- uses npm
		"clangd",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"black", -- python formatter
		"prettier", -- ts and js formatter
		"eslint_d", -- ts and js linter
		"sqlfluff", -- ts and js linter
		"clang-format",
		"cpplint",
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

-- ** lsp config **
----------------
-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap -- for conciseness
local _border = "single"

-- borders for lsp floats
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})

vim.diagnostic.config({
	float = { border = _border },
})
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.offsetEncoding = { "utf-16" }

lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["bashls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["sqlls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "opts", "on_attach" },
			},
		},
	},
})

-- ** null ls **
----------------
-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		formatting.black,
    formatting.shfmt,
		formatting.sql_formatter,
		formatting.stylua,
		diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
		formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
		formatting.clang_format,
		diagnostics.cpplint,
	},
})
