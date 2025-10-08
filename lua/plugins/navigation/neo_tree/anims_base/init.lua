local M = {}

---@param name string
---@return table
function M.load(name)
  local ok, frames = pcall(require, "plugins.navigation.neo_tree.anims_base." .. name)
  if not ok then
    return {}
  end
  return frames
end

return M
