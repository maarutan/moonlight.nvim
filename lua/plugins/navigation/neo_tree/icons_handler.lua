local const = require("utils.constants")
local which = require("utils.which")

return {
	folder_closed = const.icons.ui.folders.close,
	folder_open = const.icons.ui.folders.open,
	folder_empty = const.icons.ui.folders.empty,
	folder_empty_open = const.icons.ui.folders.empty_open,

	default = "*",
	highlight = "NeoTreeFileIcon",

	provider = function(icon, node, state)
		local open_files = _G.neo_tree_open_files or {}

		if node.type == "directory" then
			local is_open = node.is_expanded and node:is_expanded() or node.expanded
			local dir_icon = const.icons.web_icons.directories[node.name]

			if dir_icon then
				icon.text = is_open and const.icons.ui.folders.open or dir_icon
				icon.highlight = "Directory"
				return
			end
		end

		if node.type == "file" and open_files[node.path] then
			icon.text = "*"
			icon.highlight = "WarningMsg"
			return
		end

		if node.type == "file" or node.type == "terminal" then
			local ok, devicons = which:is_module_exists("nvim-web-devicons")
			local name = node.type == "terminal" and "terminal" or node.name

			if ok then
				local devicon, hl = devicons.get_icon(name)
				icon.text = devicon or icon.text
				icon.highlight = hl or icon.highlight
			end
		end
	end,
}
