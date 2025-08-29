local M = {}

local script_path = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
local config_path = script_path .. "cfg/.sassformatterrc.json"

M.format = function()
	local filepath = vim.api.nvim_buf_get_name(0)

	vim.fn.jobstart({ "sass-formatter", "--config", config_path, "-w", filepath }, {
		on_exit = function()
			vim.schedule(function()
				vim.cmd("edit!")
				vim.cmd("normal! zz")
			end)
		end,
	})

	return nil
end

return M
