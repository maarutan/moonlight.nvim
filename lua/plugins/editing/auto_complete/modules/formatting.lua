local which = require("utils.which")
local icons = require("utils.constants.icons")

local ok_lspkind = which:is_module_exists("lspkind")
local lspkind = ok_lspkind and require("lspkind") or nil

if not ok_lspkind then
	vim.notify("lspkind not found — used default icons", vim.log.levels.ERROR)
end

local lspkind_formatter = nil
if ok_lspkind and lspkind and lspkind.cmp_format then
	lspkind_formatter = lspkind.cmp_format({
		mode = "symbol_text",
		maxwidth = 50,
	})
end

return {
	fields = { "kind", "abbr", "menu" },

	format = function(entry, vim_item)
		local raw_kind = vim_item.kind

		if lspkind_formatter then
			vim_item = lspkind_formatter(entry, vim_item)
		end

		local kind_text = vim_item.kind or ""
		local strings = vim.split(kind_text, "%s", { trimempty = true })

		local icon = strings[1] or ""
		if icon == raw_kind and lspkind and lspkind.symbolic then
			icon = lspkind.symbolic(raw_kind, { mode = "symbol" }) or ""
		end

		local source_name = entry.source.name
		if icons.cmp_icons and icons.cmp_icons[source_name] then
			vim_item.kind = " " .. icons.cmp_icons[source_name] .. " "
		else
			vim_item.kind = " " .. icon .. " "
		end

		local menu_label = strings[2] or raw_kind or source_name or ""
		if menu_label ~= "" then
			menu_label = menu_label:sub(1, 1):upper() .. menu_label:sub(2)
		end
		vim_item.menu = "    [ " .. menu_label .. " ]"

		if raw_kind then
			vim_item.menu_hl_group = "CmpItemKind" .. raw_kind
		end

		return vim_item
	end,
}
