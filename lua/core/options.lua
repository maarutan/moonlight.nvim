-- ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
-- │ │├─┘ │ ││ ││││└─┐
-- └─┘┴   ┴ ┴└─┘┘└┘└─┘
--
-- ========== Core ========== --
local const = require("utils.constants")

vim.loader.enable()
local border = "rounded" -- single / double / rounded
local termianl_direction = "horizontal" -- horizontal / vertical / float
vim.opt.syntax = "off"
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"

vim.opt.guicursor = {
	"n-v-c:block",
	"c:ver25",
	"i:ver25",
}

-- ========== UI Chars ========== --
vim.opt.list = true
vim.opt.foldenable = true

vim.opt.listchars = {
	tab = const.icons.ui.listchars.indent_line .. " ",
	trail = const.icons.ui.listchars.tabs,
	extends = const.icons.ui.listchars.extends,
	precedes = const.icons.ui.listchars.precedes,
}

vim.opt.fillchars = {
	fold = " ",
	foldopen = const.icons.ui.fillchars.fold.open,
	foldclose = const.icons.ui.fillchars.fold.close,
	foldsep = " ",
	eob = " ",
}

-- ========== Search ========== --
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ========== Disable auto-comment continuation ========== --
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove("c")
		vim.opt.formatoptions:remove("r")
		vim.opt.formatoptions:remove("o")
	end,
})

-- ========== Interface ========== --
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ========== Performance & UX ========== --
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

-- ========== Files & Undo ========== --
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

local undodir = vim.fn.stdpath("data") .. "/undo"
if not vim.fn.isdirectory(undodir) then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

-- ========== Cmd-abbrevs ========== --
vim.cmd([[cabbrev Q q]])
vim.cmd([[cabbrev W w]])

return {
	border = border,
	termianl_direction = termianl_direction,
}
