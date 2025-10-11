local r = require
local icons = require("utils.icons")
local which = r("utils.which")
local ui = r("utils.ui")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local no_git_banner = [[
╔═╗┬─┐┬─┐┌─┐┬─┐
║╣ ├┬┘├┬┘│ │├┬┘
╚═╝┴└─┴└─└─┘┴└─
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
┌┬┐┌─┐┌─┐┌┐┌┬  ┬┌─┐┬ ┬┌┬┐
││││ ││ │││││  ││ ┬├─┤ │
┴ ┴└─┘└─┘┘└┘┴─┘┴└─┘┴ ┴ ┴
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-------------------------------------
]]

if not which:is_exists("git") then
	vim.api.nvim_echo({
		{ no_git_banner, "Title" },
		{ "\nGit is not installed.\n", "WarningMsg" },
		{ "Install Git for Neovim and restart!\n", "Normal" },
		{ "\n\n ~> git: https://git-scm.com/downloads\n\n\n", "Normal" },
	}, true, {})
	return
end

---@diagnostic disable-next-line: undefined-field
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.notify("Cloning lazy.nvim ...", vim.log.levels.INFO)
	local ok, out = pcall(vim.fn.system, {
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if not ok or vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ icons.emoji.error .. " Error cloning lazy.nvim:\n", "ErrorMsg" },
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

local ok_setup, err = pcall(lazy.setup, {
	spec = { r("plugins") },
	ui = { border = ui.border },
	git = { depth = 1 },
	checker = { enabled = true },
})
if not ok_setup then vim.notify("Lazy setup failed: " .. err, vim.log.levels.ERROR) end
