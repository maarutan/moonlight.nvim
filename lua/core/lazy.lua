local which = require("utils.which")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local r = require

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
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Error cloning lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\n ~> Press Enter to continue...", "Normal" },
		}, true, {})
		vim.fn.getchar()
		return
	end
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	spec = { r("plugins") },
	checker = { enabled = true },
})
