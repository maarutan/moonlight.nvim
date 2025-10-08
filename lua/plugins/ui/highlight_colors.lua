return {
	"brenoprata10/nvim-highlight-colors",
	opts = {
		--- Render style
		--- 'background' | 'foreground' | 'virtual'
		render = "background",

		--- Virtual symbol (работает, если render = 'virtual')
		virtual_symbol = "■",
		virtual_symbol_prefix = "",
		virtual_symbol_suffix = " ",
		--- 'inline' | 'eol' | 'eow'
		virtual_symbol_position = "inline",

		enable_hex = true, -- '#FFFFFF'
		enable_short_hex = true, -- '#fff'
		enable_rgb = true, -- 'rgb(0 0 0)'
		enable_hsl = true, -- 'hsl(150deg 30% 40%)'
		enable_ansi = true, -- '\033[0;34m'
		enable_hsl_without_function = true, -- '--foreground: 0 69% 69%;'
		enable_var_usage = true, -- 'var(--color-name)'
		enable_named_colors = true, -- 'red', 'green'
		enable_tailwind = true, -- 'bg-blue-500'

		exclude_filetypes = {},
		exclude_buftypes = {},
		exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end,
	},
}
