local icons = require("utils.constants.icons")
local merge = require("utils.table").merge
local terminal = require("utils.terminal")

return merge(
	{
		-- Space + c
		{ "<leader>c", group = "Comment + Ccc", mode = "n", icon = { icon = icons.ui.message } },
		{ "<leader>c", group = "Comment", mode = "x", icon = { icon = icons.ui.message } },

		-- Space + c + c
		{ "<leader>cc", group = "CCC", icon = { icon = icons.ui.drawing_pen } },

		-- Space + b
		{ "<leader>b", group = "Buffers", icon = { icon = icons.ui.buffer }, mode = "n" },

		-- Space + h
		{ "<leader>h", group = "Hop", icon = { icon = icons.ui.hop } },

		-- Space + f
		{ "<leader>f", group = "Find", icon = { icon = icons.ui.find } },

		-- Space + n
		{ "<leader>n", group = "Notifications", icon = { icon = icons.ui.notification } },

		-- Space + t
		{ "<leader>t", group = "Terminal", icon = { icon = icons.ui.mode.terminal } },

		-- Space + w
		{ "<leader>w", group = "Word", icon = { icon = icons.ui.files.word } },

		-- Space + g
		{ "<leader>g", group = "Git", icon = { icon = icons.git.git } },

		-- Space + d
		{ "<leader>d", group = "Diagnostics", icon = { icon = icons.diagnostic.debug } },

		-- Space + l - lsp
		{ "<leader>l", group = "LSP", icon = { icon = icons.ui.lsp } },

		-- Space + m
		{ "<leader>m", group = "Multicursor", icon = { icon = icons.ui.multicursor } },

		-- Space + k

		(function()
			if terminal.is_kitty() then
				return { { "<leader>k", group = "Kitty Config", icon = { icon = icons.ui.kitty } } }
			end
		end)(),
	},

	require("plugins.editing.keymaps"),
	require("plugins.ui.keymaps"),
	require("plugins.navigation.keymaps"),
	require("plugins.snacks.keymaps"),
	require("plugins.tools.keymaps"),
	require("plugins.dev.keymaps")
)
