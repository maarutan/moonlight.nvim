local M = {}

local uv = vim.uv or vim.loop

local which_ok, which = pcall(require, "utils.which")
local os_utils_ok, os_utils = pcall(require, "utils.os")
if not (which_ok and os_utils_ok) then
	return M
end

local ignore_ft = {
	image = true,
	prompt = true,
	["neo-tree"] = false,
	terminal = true,
	toggleterm = true,
	snacks_picker = true,
	TelescopePrompt = true,
	TelescopeResults = true,
	snacks_win_backdrop = true,
	snacks_picker_input = true,
}

local last_file ---@type string|nil
local skip_reveal = false

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

---@param bufnr integer
local function is_real_file(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return false
	end

	local ft = vim.bo[bufnr].filetype
	if ft == "neo-tree" then
		return false
	end
	if ignore_ft[ft] then
		return false
	end

	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		return false
	end
	if name:match("^term://") then
		return false
	end

	return true
end

function M.reveal_last_file_in_neotree()
	if not last_file then
		return
	end

	local manager_ok, manager = which:is_module_exists("neo-tree.sources.manager")
	local cmd_ok, cmd = which:is_module_exists("neo-tree.command")
	if not (manager_ok and cmd_ok) then
		return
	end

	local state = manager.get_state("filesystem")
	if not (state and state.winid and vim.api.nvim_win_is_valid(state.winid)) then
		return
	end

	local cwd = state.path or uv.cwd()
	if not is_subpath(cwd, last_file) then
		return
	end

	vim.schedule(function()
		cmd.execute({
			action = "show",
			source = "filesystem",
			reveal_file = last_file,
			focus = true,
			reveal_force_cwd = false,
		})
	end)
end

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		local bufnr = args.buf or args.bufnr
		if not bufnr then
			return
		end
		if is_real_file(bufnr) then
			last_file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufDelete" }, {
	callback = function(args)
		local deleted_buf = args.buf or args.bufnr
		if deleted_buf == vim.api.nvim_get_current_buf() then
			skip_reveal = true
		end
	end,
})

vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		local win = vim.api.nvim_get_current_win()
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.bo[buf].filetype

		if ft ~= "neo-tree" then
			return
		end

		if skip_reveal then
			skip_reveal = false
			return
		end

		M.reveal_last_file_in_neotree()
	end,
})

return M
