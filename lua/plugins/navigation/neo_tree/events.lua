local which = require("utils.which")
local event = require("neo-tree.events")

local open_files = {}

if which:is_module_exists("snacks") then
	snacks_rename = require("snacks.rename").on_rename_file
end

local M = {
	{
		event = event.NEO_TREE_BUFFER_ENTER,
		handler = function()
			vim.opt.relativenumber = true
		end,
	},

	{
		event = event.FILE_OPENED,
		handler = function(data)
			if data.node and data.node.path then
				open_files[data.node.path] = true
			end

			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if
					vim.api.nvim_buf_get_name(buf) == ""
					and vim.api.nvim_buf_get_option(buf, "buftype") == ""
				then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end,
	},
}

if snacks_rename then
	table.insert(M, {
		event = event.FILE_MOVED,
		handler = function(data)
			snacks_rename(data.source, data.destination)
		end,
	})

	table.insert(M, {
		event = event.FILE_RENAMED,
		handler = function(data)
			snacks_rename(data.source, data.destination)
		end,
	})
end

return M
