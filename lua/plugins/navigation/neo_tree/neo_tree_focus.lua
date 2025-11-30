local M = {}

local uv = vim.uv or vim.loop

local which_ok, which = pcall(require, "utils.which")
local os_utils_ok, os_utils = pcall(require, "utils.os")
if not (which_ok and os_utils_ok) then return M end

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

local last_file
local skip_reveal = false
local pending_timer = nil
local guard_timer = nil
local can_cancel = false

local function stop_and_close(t)
	if not t then return end
	pcall(function()
		t:stop()
		t:close()
	end)
end

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

local function is_real_file(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then return false end
	local ft = vim.bo[bufnr].filetype
	if ft == "neo-tree" then return false end
	if ignore_ft[ft] then return false end
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then return false end
	if name:match("^term://") then return false end
	return true
end

function M.reveal_last_file_in_neotree()
	if not last_file then return end
	local manager_ok, manager = which:is_module_exists("neo-tree.sources.manager")
	local cmd_ok, cmd = which:is_module_exists("neo-tree.command")
	if not (manager_ok and cmd_ok) then return end
	local state = manager.get_state("filesystem")
	if not (state and state.winid and vim.api.nvim_win_is_valid(state.winid)) then return end
	local cwd = state.path or uv.cwd()
	if not is_subpath(cwd, last_file) then return end
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

local grp = vim.api.nvim_create_augroup("NeoTreeReveal", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	group = grp,
	callback = function(args)
		local bufnr = args.buf or args.bufnr
		if not bufnr then return end
		if is_real_file(bufnr) then last_file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p") end
	end,
})

vim.api.nvim_create_autocmd("BufDelete", {
	group = grp,
	callback = function(args)
		local deleted_buf = args.buf or args.bufnr
		if deleted_buf == vim.api.nvim_get_current_buf() then skip_reveal = true end
	end,
})

local function cancel_pending_timer()
	if pending_timer then
		stop_and_close(pending_timer)
		pending_timer = nil
	end
	if guard_timer then
		stop_and_close(guard_timer)
		guard_timer = nil
	end
	can_cancel = false
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
	group = grp,
	callback = function()
		if not can_cancel then return end
		local buf = vim.api.nvim_get_current_buf()
		if vim.bo[buf].filetype == "neo-tree" then cancel_pending_timer() end
	end,
})

vim.api.nvim_create_autocmd("WinEnter", {
	group = grp,
	callback = function()
		if skip_reveal then
			skip_reveal = false
			return
		end
		local win = vim.api.nvim_get_current_win()
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype ~= "neo-tree" then return end
		cancel_pending_timer()
		can_cancel = false
		local timer = uv.new_timer and uv.new_timer() or vim.loop.new_timer()
		pending_timer = timer
		local guard = uv.new_timer and uv.new_timer() or vim.loop.new_timer()
		guard_timer = guard
		guard:start(
			50,
			0,
			vim.schedule_wrap(function()
				can_cancel = true
				stop_and_close(guard)
				if guard_timer == guard then guard_timer = nil end
			end)
		)
		timer:start(
			350,
			0,
			vim.schedule_wrap(function()
				if pending_timer == timer then M.reveal_last_file_in_neotree() end
				stop_and_close(timer)
				if pending_timer == timer then pending_timer = nil end
				if guard_timer then
					stop_and_close(guard_timer)
					guard_timer = nil
				end
				can_cancel = false
			end)
		)
	end,
})

return M
