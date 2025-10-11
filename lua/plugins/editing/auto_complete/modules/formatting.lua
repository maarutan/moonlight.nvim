local r = require
local which = r("utils.which")
local icons = r("utils.icons")

local ok_lspkind = which:is_module_exists("lspkind")
local lspkind = ok_lspkind and r("lspkind") or nil

if not ok_lspkind then vim.notify("lspkind not found — used default icons", vim.log.levels.ERROR) end

return {
	fields = { "kind", "abbr", "menu" },

	format = function(entry, vim_item)
		local lspkind_fmt
		if ok_lspkind and lspkind and lspkind.cmp_format then
			local fmt = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
			})
			if fmt then lspkind_fmt = fmt(entry, vim_item) end
		end

		lspkind_fmt = lspkind_fmt or vim_item

		local strings = vim.split(lspkind_fmt.kind or "", "%s", { trimempty = true })

		if icons.cmp_icons[entry.source.name] then
			lspkind_fmt.kind = " " .. icons.cmp_icons[entry.source.name] .. " "
		else
			lspkind_fmt.kind = " " .. (strings[1] or "") .. " "
		end

		local menu_label = strings[2] or entry.source.name or ""
		if menu_label ~= "" then menu_label = menu_label:sub(1, 1):upper() .. menu_label:sub(2) end
		lspkind_fmt.menu = "   [ " .. menu_label .. " ]"

		local ok_colors, colors = which:is_module_exists("nvim-highlight-colors")
		if ok_colors then
			local color_item = colors.format(entry, { kind = vim_item.kind })
			if color_item and color_item.abbr_hl_group then
				lspkind_fmt.kind_hl_group = color_item.abbr_hl_group
				lspkind_fmt.kind = color_item.abbr
			end
		end

		return lspkind_fmt
	end,
}
