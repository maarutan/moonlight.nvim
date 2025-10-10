local r = require
local icons = r("utils.icons")

return {
	folder_closed = icons.folders.close,
	folder_open = icons.folders.open,
	folder_empty = icons.folders.empty,
	folder_empty_open = icons.folders.empty_open,
	default = "*",
	highlight = "NeoTreeFileIcon",

	provider = function(icon, node, state)
		local open_files = _G.neo_tree_open_files or {}

		if node.type == "directory" then
			local is_open = node.is_expanded and node:is_expanded() or node.expanded

			for _, pair in ipairs(icons.web_icons.directories or {}) do
				local dir_name, dir_icon = pair[1], pair[2]
				if node.name == dir_name then
					icon.text = is_open and icons.folders.open or dir_icon
					icon.highlight = "Directory"
					return
				end
			end
		end

		if node.type == "file" and open_files[node.path] then
			icon.text = "*"
			icon.highlight = "WarningMsg"
			return
		end

		if node.type == "file" or node.type == "terminal" then
			local ok, devicons = pcall(require, "nvim-web-devicons")
			local name = node.type == "terminal" and "terminal" or node.name
			if ok then
				local devicon, hl = devicons.get_icon(name)
				icon.text = devicon or icon.text
				icon.highlight = hl or icon.highlight
			end
		end
	end,
}
