local M = {}

local r      = require 
local json   = r("utils.json")
local config = r("plugins.tools.kitty_term.config")

local kitty_conf = vim.fn.expand(config.setup.kitty_path)
local json_path  = vim.fn.stdpath("config") .. "/" .. config.setup.config_path

-- read kitty.conf
local function read_kitty_font()
  local f = io.open(kitty_conf, "r")
  if not f then return { font = "", size = "" } end

  local content = f:read("*a")
  f:close()

  local font = content:match("font_family%s+([^\n]+)") or ""
  local size = content:match("font_size%s+([^\n]+)") or ""

  return { font = vim.trim(font), size = vim.trim(size) }
end

-- write font to kitty.conf
local function write_kitty_font(font)
  local f = io.open(kitty_conf, "r")
  if not f then return end

  local content = f:read("*a")
  f:close()

  if content:match("font_family%s+") then
    content = content:gsub("font_family%s+.-\n", "font_family " .. font .. "\n")
  else
    content = content .. "\nfont_family " .. font .. "\n"
  end

  local out = io.open(kitty_conf, "w")
  if out then
    out:write(content)
    out:close()
  end
end

function M.reload_kitty()
  local h = io.popen("pidof kitty")
  if not h then return end
  local pid = h:read("*l")
  h:close()
  if pid and pid ~= "" then
    os.execute("kill -USR1 " .. pid)
  end
end

-- Update font in json and kitty.conf
function M.set_font(font)
  json.update(json_path, { font = font }, 2)
  write_kitty_font(font)
  M.reload_kitty()
end

-- Update size in json
function M.set_size(size)
  json.update(json_path, { size = size }, 2)
  vim.fn.system("kitty @ set-font-size " .. size)
end

function M.restore_original_font()
  local data = json.load(json_path) or {}
  if data.default_font and data.default_font ~= "" then
    write_kitty_font(data.default_font)
    M.reload_kitty()
    if data.default_size and data.default_size ~= "" then
      M.set_size(data.default_size)
    end
  end
end

function M.autostart()
  local data = json.load(json_path) or {}

  -- save default only first time
  if not data.default_font or data.default_font == "" then
    local current = read_kitty_font()
    data.default_font = current.font
    data.default_size = current.size
    json.save(json_path, data, 2)
  end

  -- apply user font on start
  if data.font and data.font ~= "" then
    write_kitty_font(data.font)
    M.reload_kitty()
  end

  -- apply user size on start
  if data.size and data.size ~= "" then
    M.set_size(data.size)
  else
    data.size = data.default_size
    json.update(json_path, { size = data.default_size }, 2)
    M.set_size(data.size)
  end
    vim.fn.system("kitty @ set-spacing padding=0")

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      M.restore_original_font()
      vim.fn.system("kitty @ set-spacing padding=default")
    end,
  })
end

function M.list_fonts_unique()
  local seen, fonts = {}, {}
  local h = io.popen("fc-list : family")
  if not h then return fonts end

  for line in h:lines() do
    for font in line:gmatch("[^,]+") do
      font = font:gsub("^%s+", ""):gsub("%s+$", "")
      if font ~= "" and not seen[font] then
        seen[font] = true
        table.insert(fonts, font)
      end
    end
  end

  h:close()
  table.sort(fonts)
  return fonts
end

return M
