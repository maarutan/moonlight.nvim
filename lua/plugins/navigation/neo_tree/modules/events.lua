local r = require
local sr = r("snacks.rename")
local event = r("neo-tree.events")
local d = "plugins.navigation.neo_tree."
local m = d .. "modules."
local anims = r(d .. "anims")

-- Lua 5.1 / 5.4
local unpack = table.unpack or unpack

local open_files = {}

return {
	{
		event = "neo_tree_buffer_enter",
		handler = function()
			vim.opt_local.relativenumber = true
		end,
	},

	{
		event = event.FILE_OPENED,
		handler = function(data)
			if data.node and data.node.path then
				open_files[data.node.path] = true
			end
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_get_name(buf) == "" and vim.api.nvim_buf_get_option(buf, "buftype") == "" then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end,
	},

	{
		event = "buf_delete",
		handler = function(args)
			local path = vim.api.nvim_buf_get_name(args.buf or 0)
			if path and path ~= "" then
				open_files[path] = nil
			end
		end,
	},

	{
		event = event.FILE_MOVED,
		handler = function(data)
			sr.on_rename_file(data.source, data.destination)
		end,
	},

	{
		event = event.FILE_RENAMED,
		handler = function(data)
			sr.on_rename_file(data.source, data.destination)
		end,
	},

	unpack(anims.event_handlers),
}
