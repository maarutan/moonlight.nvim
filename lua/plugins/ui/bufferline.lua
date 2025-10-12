local r = require
local icons = r("utils.icons")
local which = r("utils.which")
local terminal = r("utils.terminal")

local close_cmd = which:is_module_exists("bufdelete") and "Bdelete! %d" or "bdelete! %d"
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			mode = "buffers", -- set to "tabs" to only show tabpages instead
			-- style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
			themable = false, -- true | false, allows highlight groups to be overriden i.e. sets highlights as default
			-- numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
			numbers = function(opts) return string.format("%s", opts.raise(opts.ordinal)) end,
			close_command = close_cmd, -- can be a string | function, | false see "Mouse actions"
			right_mouse_command = close_cmd, -- can be a string | function | false, see "Mouse actions"
			left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
			middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
			indicator = {
				icon = icons.vertical_space_bar, -- this should be omitted if indicator style is not 'icon'
				style = "underline", -- 'icon' | 'underline' | 'none',
			},
			color_icons = true, -- true | false  whether or not to add the filetype icon highlights
			show_close_icon = true, -- true | false,
			show_tab_indicators = true, -- true | false,
			tab_size = 1,
			max_name_length = 14, -- int
			diagnostics = true, -- false | "nvim_lsp" | "coc",
			buffer_close_icon = " " .. icons.close .. " ",
			modified_icon = icons.not_save,
			close_icon = " " .. icons.close .. " ",
			left_trunc_marker = icons.left_trunc_marker,
			right_trunc_marker = icons.right_trunc_marker,
			sort_by = "insert_at_end", -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
			-- without extensions
			name_formatter = function(buf) return vim.fn.fnamemodify(buf.name, ":t:r") end,

			groups = {
				items = {
					{
						name = "",
						icon = icons.pin,
					},
				},
			},

			pick = {
				alphabet = "asdfghjklwertyuiopcvbnm",
			},

			hover = {
				enabled = false,
				delay = 100,
				reveal = { "close" },
			},

			offsets = {
				{
					filetype = "neo-tree",
					-- text = "File Explorer",
					text = "",
					text_align = "center",
					separator = true,
				},
			},
			---- custom modules
			custom_areas = {
				right = function()
					local fg = vim.g.is_day_mode and "#ffffff" or "#000000"

					local right_items = {}

					if terminal.is_kitty() then table.insert(right_items, {
						text = "  [ " .. icons.kitty.title .. "  kitty ] ",
					}) end

					table.insert(right_items, {
						text = " " .. icons.close .. " ",
						fg = fg,
						bg = "#C75B5F",
					})

					return right_items
				end,
			},
		},
	},
}
