local M = {}

function M.merge(...)
	local result = {}

	for _, list in ipairs({ ... }) do
		if type(list) == "table" then
			vim.list_extend(result, list)
		end
	end

	return result
end

return M
