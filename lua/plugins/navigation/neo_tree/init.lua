local border = require("core.options").border
local signs = require("core.options").signs
local inputs = require("neo-tree.ui.inputs")
local whitch = require("plugins.navigation.neo_tree.utils").witch
local smoothScroll = require("plugins.navigation.neo_tree.utils").smoothScroll
local events = require("plugins.navigation.neo_tree.events").event_handlers
local scrollup = require("plugins.navigation.neo_tree.commands").scrollup
local scrolldown = require("plugins.navigation.neo_tree.commands").scrolldown
local trash = require("plugins.navigation.neo_tree.commands").trash
local mappings = require("plugins.navigation.neo_tree.mappings")
local resotre = require("plugins.navigation.neo_tree.commands").resotre

require("neo-tree").setup({
	retain_hidden_root_indent = true, -- IF the root node is hidden, keep the indentation anyhow.
	hide_root_node = true, -- Hide the root node.
	popup_border_style = border,

	filesystem = {
		filtered_items = {
			hide_by_name = {
				"node_modules",
				".venv",
				".venv",
				"venv",
				".pyrightconfig.json",
				"node_modules",
			},
		},

		window = {
			position = "left",
			width = 30,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = mappings,
		},
	},

	source_selector = {
		winbar = false,
		content_layout = "center",
		tabs_layout = "equal",
		show_separator = true,
		sources = {
			{ source = "filesystem", display_name = "  File" },
			{ source = "git_status", display_name = "󰊢  Git" },
			{ source = "buffers", display_name = "󱚀  Buffers" },
		},
	},
	event_handlers = { events },

	commands = {

		scrolldown = scrolldown,
		scrollup = scrollup,

		trash = trash,
		restore = restore,

		abs_path = function(state)
			local node = state.tree:get_node()
			if node and (node.type == "file" or node.type == "directory") then
				local file_path = node:get_id()
				local last_notification_id = nil

				local function show_file_path()
					if file_path == "" then
						file_path = "Path doesn't exist"
					else
						file_path = file_path:gsub(vim.env.HOME, "~")
					end

					last_notification_id = vim.notify(file_path, vim.log.levels.INFO, {
						title = (node.type == "file" and "Current File 📄" or "Current Directory 📁"),
						replace = last_notification_id,
						timeout = 4000,
					})
				end

				show_file_path()
			end
		end,

		diff_files = function(state)
			local node = state.tree:get_node()
			local log = require("neo-tree.log")
			state.clipboard = state.clipboard or {}
			if diff_Node and diff_Node ~= tostring(node.id) then
				local current_Diff = node.id
				require("neo-tree.utils").open_file(state, diff_Node, open)
				vim.cmd("vert diffs " .. current_Diff)
				log.info("Diffing " .. diff_Name .. " against " .. node.name)
				diff_Node = nil
				current_Diff = nil
				state.clipboard = {}
				require("neo-tree.ui.renderer").redraw(state)
			else
				local existing = state.clipboard[node.id]
				if existing and existing.action == "diff" then
					state.clipboard[node.id] = nil
					diff_Node = nil
					require("neo-tree.ui.renderer").redraw(state)
				else
					state.clipboard[node.id] = { action = "diff", node = node }
					diff_Name = state.clipboard[node.id].node.name
					diff_Node = tostring(state.clipboard[node.id].node.id)
					log.info("Diff source file " .. diff_Name)
					require("neo-tree.ui.renderer").redraw(state)
				end
			end
		end,

		nil_func = function()
			return nil
		end,

		open_and_clear_filter = function(state)
			local node = state.tree:get_node()
			if node and node.type == "file" then
				local file_path = node:get_id()
				-- reuse built-in commands to open and clear filter
				local cmds = require("neo-tree.sources.filesystem.commands")
				cmds.open(state)
				cmds.clear_filter(state)
				-- reveal the selected file without focusing the tree
				require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
			end
		end,
	},
	icon = {
		folder_closed = "",
		folder_open = "",
		folder_empty = "󰜌",
		provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
			if node.type == "file" or node.type == "terminal" then
				local success, web_devicons = pcall(require, "nvim-web-devicons")
				local name = node.type == "terminal" and "terminal" or node.name
				if success then
					local devicon, hl = web_devicons.get_icon(name)
					icon.text = devicon or icon.text
					icon.highlight = hl or icon.highlight
				end
			end
		end,
		-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
		-- then these will never be used.
		default = "*",
		highlight = "NeoTreeFileIcon",
	},

	default_component_configs = {

		symbols = {
			symbol = "  [+]  ",
			highlight = "NeoTreeModified",
		},

		indent = {
			indent_size = 3,
			padding = 2, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└─",
			highlight = "NeoTreeIndentMarker",

			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},

		git_status = {
			symbols = {

				-- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "", -- this can only be used in the git_status source
				renamed = "", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "",
				staged = "",
				conflict = "",
			},
		},
	},
})
