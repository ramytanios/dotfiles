require("Comment").setup()
require("gitsigns").setup()
require("leap").add_default_mappings()
require("lualine").setup({
	options = {
		theme = "auto",
	},
})
require("neoscroll").setup()
require("netrw").setup({})
require("symbols-outline").setup()
require("trouble").setup()
require("lsp_signature").setup()
require("todo-comments").setup()
local telescope = require("telescope")
local actions = require("telescope.actions")
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
telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("emoji")
require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
	auto_install = true,
})

-- ** metals **
----------------
local api = vim.api
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
-- ** mason **
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_null_ls = require("mason-null-ls")
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
		"pyright",
		"tsserver",
		"bashls",
		"sqlls",
		"jsonls",
		"clangd",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"black",
		"prettier",
		"eslint_d",
		"sqlfluff",
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

lspconfig["tsserver"].setup({
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
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
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
