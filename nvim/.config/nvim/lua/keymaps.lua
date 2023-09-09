vim.g.mapleader = " " -- space leader keymap

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "x", '"_x')
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "fo", ":join<CR>")

-- windows plit
keymap.set("n", "<leader>nh", ":nohl<CR>") -- example /keymap and then clear highlight
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>ss", "<C-w>s") -- slit window horizontal
keymap.set("n", "<leader>se", "<C-w>=") -- make split equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split
-- general keymaps

-- managing tabs
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- open new tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

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

-- diagnostic in a float
keymap.set("n", "<leader>fd", function()
	vim.diagnostic.open_float()
end, opts)

-- oil nvim
keymap.set("n", "-", require("oil").open)

-- outline
keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<cr>")
keymap.set("n", "<leader>oc", "<cmd>SymbolsOutlineClose<cr>")

-- trouble
keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle lsp_definitions<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>tn", function()
	require("trouble").next({ skip_groups = true, jump = true })
end, { silent = true, noremap = true })
keymap.set("n", "<leader>tp", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end, { silent = true, noremap = true })

-- todo
keymap.set("n", "<leader>to", "<cmd>TodoTelescope<cr>", { silent = true, noremap = true })

---- LSP mappings
keymap.set("n", "<leader>d", vim.lsp.buf.definition)
keymap.set("n", "<leader>h", vim.lsp.buf.hover)
keymap.set("n", "<leader>i", vim.lsp.buf.implementation)
keymap.set("n", "<leader>r", vim.lsp.buf.references)
keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol)
keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol)
keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
keymap.set( "n", "<leader>f", function () vim.lsp.buf.format({timeout_ms = 3000}) end )
keymap.set("n", "<leader>a", vim.lsp.buf.code_action)
