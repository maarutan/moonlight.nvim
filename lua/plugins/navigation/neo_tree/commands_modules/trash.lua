local M = {}

M.trash = function(state)
	if witch("trash-put") then
		local node = state.tree:get_node()
		if node.type == "message" then
			return
		end
		local _, name = require("neo-tree.utils").split_path(node.path)
		local msg = string.format("you want to trash '%s' ???", name)
		inputs.confirm(msg, function(confirmed)
			if not confirmed then
				return
			end
			vim.fn.system({ "trash-put", node.path })
			require("neo-tree.sources.manager").refresh(state)
		end)
	else
		vim.notify("`trash-cli`: no found", vim.log.levels.WARN, { icon = "🚮" })
	end
end

return M
