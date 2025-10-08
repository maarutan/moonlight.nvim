local M = {}

-- === settings ===
local enabled            = false                     -- enable/disable animation
local mode               = "static"                 -- "float" or "static"
local h                  = "water_physics"          -- animation name
local padding_top        = 1                         -- empty lines above frames
local padding_bottom     = 1                         -- empty lines below frames
local delay              = 100                        -- frame delay (ms)
local static_height      = 8                          -- height for static mode
local position_offset    = (mode == "float") and -1 or 0  -- vertical offset: -1 default for float
local float_width_scale  = 0.9                        -- width scale for float mode (0–1)

-- === dependencies ===
local r  = require
local uv = vim.loop
local ui = require("utils.ui")
local timer = uv.new_timer()

local anim_loader = require("plugins.navigation.neo_tree.anims_base")
local frames_raw  = anim_loader.load(h)

local anim_buf, anim_win

local function center_frame_lines(frame, win_width)
  local centered = {}
  for _, line in ipairs(frame) do
    local len = vim.fn.strdisplaywidth(line)
    local left = math.max(math.floor((win_width - len) / 2), 0)
    local right = math.max(win_width - len - left, 0)
    table.insert(centered, string.rep(" ", left) .. line .. string.rep(" ", right))
  end
  return centered
end

local function make_padded_frames(frames, win_width)
  local top_pad, bottom_pad, padded = {}, {}, {}
  for _ = 1, padding_top do table.insert(top_pad, "") end
  for _ = 1, padding_bottom do table.insert(bottom_pad, "") end
  for _, frame in ipairs(frames) do
    local c = center_frame_lines(frame, win_width)
    for i = 1, #top_pad do table.insert(c, 1, "") end
    for i = 1, #bottom_pad do table.insert(c, "") end
    table.insert(padded, c)
  end
  return padded
end

local function find_neotree_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match("neo%-tree") then
      return win, buf
    end
  end
end

local function set_clean_buf(buf)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
end

local function set_clean_win(win)
  vim.wo[win].number         = false
  vim.wo[win].relativenumber = false
  vim.wo[win].cursorline     = false
  vim.wo[win].signcolumn     = "no"
  vim.wo[win].foldcolumn     = "0"
  vim.wo[win].winhighlight   = "Normal:Normal"
end

function M.start()
  if not enabled then return end
  local nwin, _ = find_neotree_win()
  if not nwin then return end

  if anim_win and vim.api.nvim_win_is_valid(anim_win) then return end

  anim_buf = vim.api.nvim_create_buf(false, true)
  set_clean_buf(anim_buf)

  local nt_width = vim.api.nvim_win_get_width(nwin)
  local anim_width = nt_width
  local frames

  if mode == "float" then
    anim_width = math.floor(nt_width * float_width_scale)
  end

  frames = make_padded_frames(frames_raw, anim_width)

  if mode == "float" then
    local nt_height = vim.api.nvim_win_get_height(nwin)
    local anim_height = #frames[1]

    local row_offset = math.max(
      (nt_height - anim_height - 1) + position_offset,
      0
    )

    anim_win = vim.api.nvim_open_win(anim_buf, false, {
      relative = "win",
      win      = nwin,
      width    = anim_width,
      height   = anim_height,
      row      = row_offset,
      col      = 0,
      style    = "minimal",
      border   = ui.border,
      focusable= false,
    })
    set_clean_win(anim_win)

  else
    local base_row = vim.api.nvim_win_get_height(nwin) - static_height
    local row_offset = math.max(base_row + position_offset, 0)

    anim_win = vim.api.nvim_open_win(anim_buf, false, {
      relative = "win",
      win      = nwin,
      width    = nt_width,
      height   = static_height,
      row      = row_offset,
      col      = 0,
      style    = "minimal",
      focusable= false,
    })
    set_clean_win(anim_win)
    vim.api.nvim_buf_set_lines(anim_buf, 0, -1, false, frames[1])
  end

  local i = 1
  timer:start(0, delay, function()
    vim.schedule(function()
      local nwin2 = find_neotree_win()
      if not nwin2 then return M.stop() end
      if anim_win and vim.api.nvim_win_is_valid(anim_win) then
        local new_w = (mode == "float")
          and math.floor(vim.api.nvim_win_get_width(nwin2) * float_width_scale)
          or vim.api.nvim_win_get_width(nwin2)

        vim.api.nvim_win_set_width(anim_win, new_w)

        local frame = center_frame_lines(frames_raw[i], new_w)
        vim.api.nvim_buf_set_lines(anim_buf, 0, -1, false, frame)
        i = (i % #frames_raw) + 1
      end
    end)
  end)
end

function M.stop()
  if timer:is_active() then timer:stop() end
  if anim_win and vim.api.nvim_win_is_valid(anim_win) then
    vim.api.nvim_win_close(anim_win, true)
  end
  anim_win, anim_buf = nil, nil
end

vim.api.nvim_create_autocmd("WinResized", {
  callback = function()
    if enabled then
      M.stop()
      M.start()
    end
  end
})

M.event_handlers = {
  { event = "after_render", handler = function() if enabled then M.start() end end },
  { event = "neo_tree_window_after_close", handler = function() M.stop() end },
}

return M
