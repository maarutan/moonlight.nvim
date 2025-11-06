local M = {}

M.setup = {
	config_path = "kitty-lock.json",
	kitty_path = vim.fn.stdpath("config"):gsub("/nvim$", "") .. "/kitty/kitty.conf",
	kitty_path_local = vim.fn.stdpath("data") .. "/kitty/nvim_font.conf",
}

M.default_config_json = {
	font = "",
	size = "0",
}

return M
