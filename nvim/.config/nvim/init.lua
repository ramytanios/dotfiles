require("plugins-setup")
require("options")
require("keymaps")
local status, _ = pcall(vim.cmd, "colorscheme kanagawa")
if not status then
	print("Colorscheme not found!")
	return
end
require("config")
