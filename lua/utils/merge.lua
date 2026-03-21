local M = {}

function M.modules(modules)
	local result = {}

	for _, module in ipairs(modules) do
		local ok, mod = pcall(require, module)
		if ok and type(mod) == "table" then
			vim.list_extend(result, mod)
		end
	end

	return result
end

return M
