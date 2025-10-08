local M = {}

function M.is_kitty()
  if os.getenv("KITTY_WINDOW_ID") ~= nil then
    return true
  end

  local term = os.getenv("TERM")
  if term and term:lower():match("kitty") then
    return true
  end

  local tp = os.getenv("TERM_PROGRAM")
  if tp and tp:lower():match("kitty") then
    return true
  end

  return false
end

return M
