local which = require("utils.which")

local ok, lint = which:is_module_exists("lint")
if not ok then
	return
end

if not which:is_exists("eslint_d") then
	return
end

lint.linters_by_ft.javascript = { "eslint_d" }
lint.linters_by_ft.typescript = { "eslint_d" }
lint.linters_by_ft.javascriptreact = { "eslint_d" }
lint.linters_by_ft.typescriptreact = { "eslint_d" }

local group = vim.api.nvim_create_augroup("EslintD", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
	group = group,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if lint.linters_by_ft[ft] then
			lint.try_lint()
		end
	end,
})
