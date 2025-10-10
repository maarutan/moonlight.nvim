local r =  require 
local icons = r("utils.icons")
local M = {}

local toggles = {
	{
		["true"] = "false",
		["false"] = "true",
	},
	{
		["yes"] = "no",
		["no"] = "yes",
	},
	{
		["on"] = "off",
		["off"] = "on",
	},
	{
		["enabled"] = "disabled",
		["disabled"] = "enabled",
	},
	{
		["enable"] = "disable",
		["disable"] = "enable",
	},
	{
		["plus"] = "minus",
		["minus"] = "plus",
	},
	{
		["+"] = "-",
		["-"] = "+",
	},
}

local function match_case_pattern(original, new)
	local result = {}
	for i = 1, #new do
		local orig_char = original:sub(i, i)
		local new_char = new:sub(i, i)
		if orig_char:match("%u") then
			table.insert(result, new_char:upper())
		else
			table.insert(result, new_char:lower())
		end
	end
	return table.concat(result)
end

-- поиск пары в массиве toggles
local function find_toggle_pair(word)
	local lower = word:lower()
	for _, group in ipairs(toggles) do
		if group[lower] then return group[lower] end
	end
	return nil
end

function M.toggle_word()
	local word = vim.fn.expand("<cword>")
	if not word or word == "" then
		vim.notify((icons.emoji and icons.emoji.warn or "⚠️") .. " No word under cursor", vim.log.levels.WARN)
		return
	end

	local base_new = find_toggle_pair(word)
	if not base_new then
		vim.notify((icons.emoji and icons.emoji.warn) .. " Can't toggle: " .. word, vim.log.levels.WARN)
		return
	end

	local new = match_case_pattern(word, base_new)
	local line = vim.api.nvim_get_current_line()
	local s, e = line:find(word, 1, true)
	if not s then return end

	local new_line = line:sub(1, s - 1) .. new .. line:sub(e + 1)
	vim.api.nvim_set_current_line(new_line)

	if next(vim.lsp.get_clients({ bufnr = 0 })) then vim.lsp.buf.format({ async = true }) end

	-- vim.notify((icons.emoji and icons.emoji.success) .. " " .. word .. " → " .. new, vim.log.levels.WARN)
end

return M
