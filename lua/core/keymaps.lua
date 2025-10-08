local r = require
local helper = r("core.helper")
local map = vim.keymap.set

-- [ ------------------------------------------------------]

vim.g.mapleader = " " -- Set leader key to space

-- Escape
map("i", "jk", "<Esc>", { silent = true, desc = "Exit Insert mode" })

-- Select all
map({ "i", "n" }, "<C-a>", function() helper.select_all() end, { silent = true, desc = "Select All" })

-- Scroll
map({"n", "x"}, "<C-u>", function() helper.scroll:start(true) end, { silent = false, desc = "Scroll up" })
map({"n", "x"}, "<C-d>", function() helper.scroll:start(false) end, { silent = false, desc = "Scroll down" })

-- Clear search
map({'n','v'}, '<Esc>', '<Esc><cmd>nohlsearch<CR>', { silent = true, desc = "Clear search highlight" })

-- [ ------------------------------------------------------]
