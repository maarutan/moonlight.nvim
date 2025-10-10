local icons = require("utils.icons")
local M = {}

local toggles = {
	["true"] = "false",
	["false"] = "true",
	["True"] = "False",
	["False"] = "True",
	["yes"] = "no",
	["no"] = "yes",
	["on"] = "off",
	["off"] = "on",
	["enabled"] = "disabled",
	["disabled"] = "enabled",
}

function M.toggle_word()
	local word = vim.fn.expand("<cword>")
	local new = toggles[word]
	if not new then
		vim.notify(icons.emoji.warn .. " Can't toggle " .. word, vim.log.levels.WARN)
		return
	end

	local line = vim.api.nvim_get_current_line()
	local s, e = line:find(word, 1, true)
	if not s then return end

	local new_line = line:sub(1, s - 1) .. new .. line:sub(e + 1)
	vim.api.nvim_set_current_line(new_line)

	if next(vim.lsp.get_clients({ bufnr = 0 })) then vim.lsp.buf.format({ async = true }) end
end

return M
