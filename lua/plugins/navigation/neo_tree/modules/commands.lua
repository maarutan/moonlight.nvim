local r = require
local icons = r("utils.icons")
local nt = r("neo-tree")
local manager = r("neo-tree.sources.manager")
local commands = r("neo-tree.sources.common.commands")
local Trash_cli = r("utils.trash_cli")
local inputs = r("neo-tree.ui.inputs")
local which = r("utils.which")
local renderer = r("neo-tree.ui.renderer")
local which_key_is_show = false

local trash = Trash_cli:new()

return {
	none = function() return nil end,

	which_key = function()
		if not which:is_module_exists("which-key") then return end

		if not which_key_is_show then
			vim.cmd("WhichKey")
			which_key_is_show = true
		else
			-- simulate <Esc> safely (works in non-modifiable buffers)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			which_key_is_show = false
		end
	end,

	visual_line = function(state) vim.cmd("normal! V") end,

	toggle_hide_root_node = function(state)
		local cfg = nt.config
		cfg.hide_root_node = not cfg.hide_root_node
		manager.refresh(state)
	end,

	copy_file_name = function(state)
		local node = state.tree:get_node()
		if not node then return end
		vim.fn.setreg("+", node.name)
	end,

	copy_file_path = function(state)
		local node = state.tree:get_node()
		if not node then return end
		vim.fn.setreg("+", node.path)
	end,

	copy_dir_path = function(state)
		local node = state.tree:get_node()
		if not node then return end
		local path = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
		vim.fn.setreg("+", path)
	end,

	copy_filename_without_ext = function(state)
		local node = state.tree:get_node()
		if not node or node.type ~= "file" then return end
		local name = vim.fn.fnamemodify(node.path, ":t:r")
		vim.fn.setreg("+", name)
	end,

	smart_enter = function(state)
		local node = state.tree:get_node()
		if not node then return end
		if node.type == "directory" then
			state.commands["toggle_node"](state)
		else
			state.commands["open"](state)
		end
	end,

	put_trash = function(state)
		local node = state.tree:get_node()
		if not node then return end

		if which:ensure_method(trash, "put") then
			local msg = string.format("Move '%s' to trash?", node.name)
			inputs.confirm(msg, function(confirmed)
				if not confirmed then return end
				trash:put(node.path)
				manager.refresh(state)
			end)
		else
			-- Fallback
			commands.delete(state)
			manager.refresh(state)
		end
	end,

	put_trash_visual = function(state, selected_nodes)
		if not which:ensure_method(trash, "put") then return end

		local paths = {}
		for _, n in ipairs(selected_nodes or {}) do
			if n.type ~= "message" then table.insert(paths, n.path) end
		end
		if #paths == 0 then return end

		inputs.confirm(("Trash %d item%s?"):format(#paths, #paths > 1 and "s" or ""), function(ok)
			if not ok then return end
			for _, p in ipairs(paths) do
				trash:put(p)
			end
			manager.refresh(state)
		end)
	end,

	restore_from_trash = function(state)
		local last_item = "unknown"
		if which:ensure_method(trash, "last_restorable_name") then last_item = trash:last_restorable_name() or "unknown" end

		if which:ensure_method(trash, "restore") then
			local msg = string.format("Restore '%s' from trash?", last_item)
			inputs.confirm(msg, function(confirmed)
				if not confirmed then return end
				trash:restore()
				manager.refresh(state)
			end)
		end
	end,
}
