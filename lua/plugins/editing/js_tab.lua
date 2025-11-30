local M = {}

local js_like = {
	js = true,
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
	jsx = true,
	tsx = true,
}

local function is_js_file() return js_like[vim.bo.filetype] or false end

function M.smart_tab()
	if not is_js_file() then return "\t" end

	local col = vim.fn.col(".")
	local line = vim.fn.getline(".")
	local prev_char = line:sub(col - 1, col - 1)
	local next_char = line:sub(col, col)

	if prev_char == "(" then
		local rest = line:sub(col)
		if rest:match("^%s*%)") then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right> => ", true, false, true), "i", false)
			return ""
		end
	end

	return "\t"
end

vim.keymap.set("i", "<Tab>", M.smart_tab, { expr = true, noremap = true })

return M
