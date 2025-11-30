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
	local next_chars = line:sub(col, col + 1)

	if next_chars == "()" or next_chars:sub(1, 1) == ")" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right><Right> => ", true, false, true), "n", false)
		return ""
	else
		return "\t"
	end
end

vim.keymap.set("i", "<Tab>", M.smart_tab, { expr = true, noremap = true })

return M
