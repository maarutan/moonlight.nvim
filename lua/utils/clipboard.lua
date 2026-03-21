local M = {}

function M.set(value)
	if value and value ~= "" then
		vim.fn.setreg("+", value)
	end
end

return M
