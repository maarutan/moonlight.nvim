local M = {}

local script_path = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
local config_path = script_path .. "cfg/.prettierrc"
M.format = function()
	return {
		exe = "prettierd",
		args = { "--config", config_path, vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

return M
