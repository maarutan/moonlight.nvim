local const = require("utils.constants")
local options = require("core.options")
local which = require("utils.which")
local deps_handler = require("utils.dependencies_handler")

if deps_handler.is_not_found_deps then
	return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.loop

if not uv.fs_stat(lazypath) then
	vim.notify("Cloning lazy.nvim ...", vim.log.levels.INFO)
	local ok, out = pcall(vim.fn.system, {
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if not ok or vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ const.icons.diagnostic.error .. " Error cloning lazy.nvim:\n", "ErrorMsg" },
			{ out or "unknown error", "WarningMsg" },
			{ "\n ~> Press Enter to continue...", "Normal" },
		}, true, {})
		vim.fn.getchar()
		return
	end
end

vim.opt.rtp:prepend(lazypath)

local ok, lazy = which:is_module_exists("lazy")
if not ok then
	vim.notify("Failed to load lazy.nvim", vim.log.levels.ERROR)
	return
end

---@diagnostic disable-next-line: redefined-local
local ok, err = which:safe_setup("lazy", {
	spec = { require("plugins") },
	checker = { enabled = false },
})

if not ok then
	vim.notify("Lazy setup failed: " .. err, vim.log.levels.ERROR)
	return
end
