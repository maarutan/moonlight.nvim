local M = {}

M.event_handlers = {
	event = "neo_tree_buffer_enter",
	handler = function(arg)
		vim.cmd([[
      setlocal relativenumber
    ]])
	end,
}

M.event_handlers = {
	event = require("neo-tree.events").FILE_OPENED,
	handler = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_get_name(buf) == "" and vim.api.nvim_buf_get_option(buf, "buftype") == "" then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end,
}

M.event_handlers = {
	event = require("neo-tree.events").FILE_MOVED,
	handler = function(data)
		require("snacks.rename").on_rename_file(data.source, data.destination)
	end,
}

M.event_handlers = {
	event = require("neo-tree.events").FILE_RENAMED,
	handler = function(data)
		require("snacks.rename").on_rename_file(data.source, data.destination)
	end,
}

return M
