local M = {}

local config = vim.fn.stdpath("config")

function M.nvim_config_dir()
	return config
end

function M.user_config_dir()
	return vim.fs.dirname(config)
end

function M.nvim_data_dir()
	return vim.fn.stdpath("data")
end

return M
