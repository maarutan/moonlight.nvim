local M = {}

local r = require
local uv = vim.uv or vim.loop
local timer = uv.new_timer()
local which = r("utils.which")
local last

local ignore_ft = {
	"image",
	"prompt",
	"neo-tree",
	"terminal",
	"snacks_picker",
	"TelescopePrompt",
	"TelescopeResults",
	"snacks_win_backdrop",
	"snacks_picker_input",
}

local function ignored()
	local ft = vim.bo.filetype
	for _, x in ipairs(ignore_ft) do
		if x == ft then
			return true
		end
	end
	return false
end

local function neotree_cmd()
	local ok, cmd = which:is_module_exists("neo-tree.command")
	if not ok then
		return nil
	end
	return cmd
end

function M.always_focus()
	if ignored() or not vim.api.nvim_buf_is_valid(0) then
		return
	end

	local file = vim.fn.expand("%:p")
	if file == "" then
		return
	end
	if file == last then
		return
	end
	last = file

	timer:stop()
	timer:start(250, 0, function()
		vim.schedule(function()
			local manager_ok, manager = which:is_module_exists("neo-tree.sources.manager")
			local cmd = neotree_cmd()
			if not (manager_ok and cmd) then
				return
			end

			local state = manager.get_state("filesystem")
			if not (state and state.winid and vim.api.nvim_win_is_valid(state.winid)) then
				return
			end

			cmd.execute({
				action = "show",
				source = "filesystem",
				reveal_file = file,
				focus = false,
				reveal_force_cwd = false,
			})
		end)
	end)
end

return M
