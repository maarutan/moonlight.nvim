local neotree_command = require("neo-tree.command")
local manager = require("neo-tree.sources.manager")

local function has_real_split()
	local real_windows = 0

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.bo[buf].filetype
		local bt = vim.bo[buf].buftype

		if ft ~= "neo-tree" and ft ~= "noice" and ft ~= "smear-cursor" and bt == "" then
			real_windows = real_windows + 1
		end
	end

	return real_windows > 1
end

local function smart_toggle()
	local state = manager.get_state("filesystem")

	local is_open = state and state.winid and vim.api.nvim_win_is_valid(state.winid)
	local is_focused = vim.bo.filetype == "neo-tree"
	local has_split = has_real_split()

	if not is_open then
		neotree_command.execute({ action = "focus", source = "filesystem" })
		return
	end

	if is_focused then
		neotree_command.execute({ action = "close", source = "filesystem" })
		return
	end

	if not has_split then
		neotree_command.execute({ action = "close", source = "filesystem" })
		return
	end

	neotree_command.execute({ action = "focus", source = "filesystem" })
end

return smart_toggle
