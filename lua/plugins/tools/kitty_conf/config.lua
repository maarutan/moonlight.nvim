local paths = require("utils.paths")

local M = {}

M.kitty_path = paths.user_config_dir() .. "/kitty"
M.kitty_runtime_dir = paths.nvim_data_dir() .. "/kitty_runtime"

M.kitty_config = M.kitty_path .. "/kitty.conf"
M.kitty_runtime_file = M.kitty_runtime_dir .. "/kitty.conf"
M.kitty_json_base = M.kitty_runtime_dir .. "/kitty.json"

M.default_font_size = 15
M.min_font_size = 6
M.max_font_size = 60

return M
