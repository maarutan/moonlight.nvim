local smooth_scroll = require("utils.smooth_scroll")
local cursor = require("utils.cursor")

local map = vim.keymap.set
-- [ ------------------------------------------------------]

vim.g.mapleader = " " -- Set leader key to space

-- Escape
map("i", "jk", "<Esc>", { silent = true, desc = "Exit Insert mode" })

-- Select all
map({ "i", "n" }, "<C-a>", function()
	cursor.select_all()
end, { silent = true, desc = "Select All" })

-- Scroll
map({ "n", "x" }, "<C-u>", function()
	smooth_scroll.up()
end, { silent = false, desc = "Scroll up" })

map({ "n", "x" }, "<C-d>", function()
	smooth_scroll.down()
end, { silent = false, desc = "Scroll down" })

-- Clear search
map({ "n", "x" }, "<Esc>", function () vim.cmd("nohlsearch") end, { silent = true, desc = "Clear search highlight" })

-- Save
map({ "i", "n", "x" }, "<C-s>", "<cmd>w<cr>", { silent = true, desc = "Save File" })
map({ "i", "n", "x" }, "<C-cr>", "<cmd>w<cr>", { silent = true, desc = "Save File" })

-- Increment/decrement
map({ "n", "x" }, "=", "<C-a>", { noremap = true })
map({ "n", "x" }, "-", "<C-x>", { noremap = true })

-- [ ------------------------------------------------------]
