local which = require("utils.which")

local ok, lint = which:is_module_exists("lint")
if not ok then
	return
end

if not which:is_exists("selene") then
	return
end

lint.linters_by_ft = {
	lua = { "selene" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})
