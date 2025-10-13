local M = {}

local uv = vim.uv or vim.loop
local timer = uv.new_timer()

local which_ok, which = pcall(require, "utils.which")
local os_utils_ok, os_utils = pcall(require, "utils.os")
if not (which_ok and os_utils_ok) then return M end

local ignore_ft = {
	"image",
	"prompt",
	"neo-tree",
	"terminal",
	"toggleterm",
	"snacks_picker",
	"TelescopePrompt",
	"TelescopeResults",
	"snacks_win_backdrop",
	"snacks_picker_input",
}

local function ignored()
	local ft = vim.bo.filetype
	for _, x in ipairs(ignore_ft) do
		if x == ft then return true end
	end
	return false
end

local function neotree_cmd()
	local ok, cmd = which:is_module_exists("neo-tree.command")
	if not ok then return nil end
	return cmd
end

---@param parent string
---@param child string
local function is_subpath(parent, child)
	parent = vim.fs.normalize(parent)
	child = vim.fs.normalize(child)

	local os_name = os_utils.get()
	if os_name == os_utils.windows or os_name == os_utils.wsl then
		parent = parent:lower()
		child = child:lower()
	end

	return child:sub(1, #parent) == parent
end

local last

function M.always_focus()
	if ignored() or not vim.api.nvim_buf_is_valid(0) then return end

	local file = vim.fn.expand("%:p")
	if file == "" or file == last or file:match("^term://") then return end
	last = file

	if timer:is_active() then timer:stop() end
	timer:start(300, 0, function()
		vim.schedule(function()
			local manager_ok, manager = which:is_module_exists("neo-tree.sources.manager")
			local cmd = neotree_cmd()
			if not (manager_ok and cmd) then return end

			local state = manager.get_state("filesystem")
			if not (state and state.winid and vim.api.nvim_win_is_valid(state.winid)) then return end

			local cwd = state.path or vim.loop.cwd()
			if not is_subpath(cwd, file) then return end

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

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		if timer and not timer:is_closing() then
			timer:stop()
			timer:close()
		end
	end,
})

return M
