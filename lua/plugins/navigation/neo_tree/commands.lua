local neo_tree = require("neo-tree")
local neo_tree_manager = require("neo-tree.sources.manager")

local inputs = require("neo-tree.ui.inputs")
local which = require("utils.which")
local set_clipboard = require("utils.clipboard").set
local trash_cli = require("utils.trash_cli"):new()

-- =====================================
-- Helpers
-- =====================================

local function get_node(state)
	if not state or not state.tree then
		return nil
	end

	local node = state.tree:get_node()
	if not node then
		return nil
	end

	return node
end

local function get_parent_path(node)
	if node.type == "directory" then
		return node.path
	end
	return vim.fn.fnamemodify(node.path, ":h")
end

-- =====================================
-- Actions
-- =====================================

return {

	-- do nothing
	none = function()
		return nil
	end,

	-- visual select line
	visual_line = function()
		vim.cmd("normal! V")
	end,

	-- toggle root visibility (global)
	toggle_hide_root_node = function(state)
		neo_tree.config.hide_root_node = not neo_tree.config.hide_root_node
		neo_tree_manager.refresh(state)
	end,

	-- copy file name
	copy_file_name = function(state)
		local node = get_node(state)
		if not node then
			return
		end
		set_clipboard(node.name)
	end,

	-- copy full item path
	copy_item_path = function(state)
		local node = get_node(state)
		if not node then
			return
		end

		local path

		if node.type == "directory" then
			path = node.path
		else
			path = node.path
		end

		set_clipboard(path)
	end,

	-- copy directory name
	copy_dir_name = function(state)
		local node = get_node(state)
		if not node then
			return
		end

		local path = get_parent_path(node)
		local name = vim.fn.fnamemodify(path, ":t")
		set_clipboard(name)
	end,

	-- copy item name without extension
	copy_item_name_without_ext = function(state)
		local node = get_node(state)
		if not node then
			return
		end

		if node.type == "file" then
			local name = vim.fn.fnamemodify(node.path, ":t:r")
			set_clipboard(name)
		else
			local path = get_parent_path(node)
			local name = vim.fn.fnamemodify(path, ":t")
			set_clipboard(name)
		end
	end,

	-- smart enter (directory toggle / file open)
	smart_enter = function(state)
		local node = get_node(state)
		if not node then
			return
		end

		if node.type == "directory" then
			state.commands.toggle_node(state)
		else
			state.commands.open(state)
		end
	end,
	put_trash = function(state)
		local node = state.tree:get_node()
		if not node then
			return
		end

		if which:ensure_method(trash_cli, "put") then
			local msg = string.format("Move '%s' to trash?", node.name)
			inputs.confirm(msg, function(confirmed)
				if not confirmed then
					return
				end
				trash_cli:put(node.path)
				neo_tree_manager.refresh(state)
			end)
		else
			state.commands.delete(state)
			neo_tree_manager.refresh(state)
		end
	end,
	put_trash_visual = function(state, selected_nodes)
		if not which:ensure_method(trash_cli, "put") then
			return
		end

		local paths = {}
		for _, n in ipairs(selected_nodes or {}) do
			if n.type ~= "message" then
				table.insert(paths, n.path)
			end
		end
		if #paths == 0 then
			return
		end

		inputs.confirm(("Trash %d item%s?"):format(#paths, #paths > 1 and "s" or ""), function(ok)
			if not ok then
				return
			end
			for _, p in ipairs(paths) do
				trash_cli:put(p)
			end
			neo_tree_manager.refresh(state)
		end)
	end,
	restore_from_trash = function(state)
		local last_item = "unknown"
		if which:ensure_method(trash_cli, "last_restorable_name") then
			last_item = trash_cli:last_restorable_name() or "unknown"
		end

		if which:ensure_method(trash_cli, "restore") then
			local msg = string.format("Restore '%s' from trash?", last_item)
			inputs.confirm(msg, function(confirmed)
				if not confirmed then
					return
				end
				trash_cli:restore()
				neo_tree_manager.refresh(state)
			end)
		end
	end,
}
