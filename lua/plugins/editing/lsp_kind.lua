local icons = require("utils.constants.icons.cmp_icons")

return {
	"onsails/lspkind.nvim",
	config = function()
		require("lspkind").init({
			mode = "text_symbol",
			preset = "default",

			symbol_map = {
				Text = icons.Text,
				Method = icons.Method,
				Function = icons.Function,
				Constructor = icons.Constructor,
				Field = icons.Field,
				Variable = icons.Variable,
				Class = icons.Class,
				Interface = icons.Interface,
				Module = icons.Module,
				Property = icons.Property,
				Unit = icons.Unit,
				Value = icons.Value,
				Enum = icons.Enum,
				Keyword = icons.Keyword,
				Snippet = icons.Snippet,
				Color = icons.Color,
				File = icons.File,
				Reference = icons.Reference,
				Folder = icons.Folder,
				EnumMember = icons.EnumMember,
				Constant = icons.Constant,
				Struct = icons.Struct,
				Event = icons.Event,
				Operator = icons.Operator,
				TypeParameter = icons.TypeParameter,
			},
		})
	end,
}
