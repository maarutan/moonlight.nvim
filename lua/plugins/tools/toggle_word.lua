local r = require
local icons = r("utils.icons")
local M = {}

local toggles = {
	{ ["true"] = "false", ["false"] = "true" },
	{ ["yes"] = "no", ["no"] = "yes" },
	{ ["on"] = "off", ["off"] = "on" },
	{ ["enabled"] = "disabled", ["disabled"] = "enabled" },
	{ ["enable"] = "disable", ["disable"] = "enable" },
	{ ["plus"] = "minus", ["minus"] = "plus" },
	{ ["+"] = "-", ["-"] = "+" },
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

local function find_toggle_pair(word)
	local lower = word:lower()
	for _, group in ipairs(toggles) do
		if group[lower] then
			return group[lower]
		end
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
		vim.notify((icons.emoji and icons.emoji.warn or "⚠️") .. " Can't toggle: " .. word, vim.log.levels.WARN)
		return
	end

	local new = match_case_pattern(word, base_new)

	local pos = vim.api.nvim_win_get_cursor(0)
	local row, col = pos[1], pos[2]
	local line = vim.api.nvim_get_current_line()

	local s, e = line:find(word, col + 1, true)
	if not s then
		for start_idx, matched, end_idx in line:gmatch("()(%w+)()") do
			if start_idx - 1 <= col and end_idx - 2 >= col then
				s, e = start_idx, end_idx - 1
				break
			end
		end
	end

	if not s or not e then
		return
	end

	local new_line = line:sub(1, s - 1) .. new .. line:sub(e + 1)
	vim.api.nvim_set_current_line(new_line)
	vim.api.nvim_win_set_cursor(0, { row, s - 1 })
end

return M
