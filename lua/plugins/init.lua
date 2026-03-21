-- Custom Plugins --
require("plugins.editing.js_tab")
require("plugins.tools.kitty_conf").setup()

-- Lazy Plugins --
return {

	--Libraries
	require("libs"),

	-- Navigation
	require("plugins.navigation.neo_tree"),
	require("plugins.navigation.hop"),

	-- Editing
	require("plugins.editing.no_cut"),
	require("plugins.editing.go_move"),
	require("plugins.editing.multicursor"),
	require("plugins.editing.autopairs"),
	require("plugins.editing.surround"),
	require("plugins.editing.todo_comments"),
	require("plugins.editing.ufo"),
	require("plugins.editing.bufdelete"),
	require("plugins.editing.auto_complete"),
	require("plugins.editing.comments"),

	-- Tools
	require("plugins.tools.ts_autotag"),
	require("plugins.tools.toggle_terminal"),
	require("plugins.tools.waka_time"), -- comment this line to disable wakatime
	require("plugins.tools.smear_cursor"),
	require("plugins.tools.lspsaga"),
	require("plugins.tools.git_graph"),
	require("plugins.tools.ccc"),
	require("plugins.tools.dadbod"),
	require("plugins.tools.kitty_conf.plugins.kitty_scrollback"),

	-- Ai
	require("plugins.ai.windsurf"),

	-- Ui
	require("plugins.ui.web_devicons"),
	require("plugins.ui.scrollview"),
	require("plugins.ui.notify_macro"),
	require("plugins.ui.noice"),
	require("plugins.ui.matchup"),
	require("plugins.ui.indent_line"),
	require("plugins.ui.illuminate"),
	require("plugins.ui.highlight_log"),
	require("plugins.ui.highlight_colors"),
	require("plugins.ui.gitsigns"),
	require("plugins.ui.cinnamon"),
	require("plugins.ui.bufferline"),
	require("plugins.ui.lualine"),

	-- Colorscheme
	require("plugins.colorscheme"),

	-- Snacks
	require("plugins.snacks"),

	-- Keymaps
	require("plugins.which_key"),

	-- Development
	require("plugins.dev.mason"),
	require("plugins.dev.lsp"),
	require("plugins.dev.formatters"),
	require("plugins.dev.snippets"),
	require("plugins.dev.tree_sitter"),
}
