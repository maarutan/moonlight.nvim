local which = require("utils.which")

local ok_lspkind = which:is_module_exists("lspkind")
local lspkind = ok_lspkind and require("lspkind") or nil

if not ok_lspkind then
	vim.notify("lspkind not found — used default icons", vim.log.levels.WARN)
end

local lspkind_format = nil
if ok_lspkind and lspkind and lspkind.cmp_format then
	lspkind_format = lspkind.cmp_format({
		mode = "symbol_text",
		maxwidth = 50,
	})
end

local ok_colors = which:is_module_exists("nvim-highlight-colors")
local colors = ok_colors and require("nvim-highlight-colors") or nil

return {
	fields = { "kind", "abbr", "menu" },

	format = function(entry, vim_item)
		local item = lspkind_format and lspkind_format(entry, vim_item) or vim_item

		local menu_label = entry.source.name or ""
		if menu_label ~= "" then
			menu_label = menu_label:sub(1, 1):upper() .. menu_label:sub(2)
		end
		item.menu = "   [ " .. menu_label .. " ]"

		if colors and colors.format then
			local color_item = colors.format(entry, { kind = vim_item.kind })
			if color_item and color_item.abbr_hl_group then
				item.abbr_hl_group = color_item.abbr_hl_group
			end
		end

		return item
	end,
}
