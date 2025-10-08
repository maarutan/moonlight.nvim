local r = require
local icons = r("utils.icons")
local which = r("utils.which")

local module_name = "noice"

return {
  function()
    local ok, noice = which:is_module_has(module_name)
    if not ok or not noice or not noice.api or not noice.api.status or not noice.api.status.command then
      return "[ " .. (icons.noice and icons.noice.not_found or "") .. " not found `noice` ]"
    end

    local command = noice.api.status.command.get()

    if command and command ~= "" then
      if command:sub(1, 1) == "<" or command == "j" then
        return " " .. (icons.noice and icons.noice.command or "") .. " "
      else
        return command
      end
    else
      return " " .. (icons.noice and icons.noice.command or "") .. " "
    end
  end,

  color = function()
    local ok, _ = which:is_module_has(module_name)
    if not ok then
      return { fg = "#990000" }
    else
      return { fg = "#ffffff" }
    end
  end,
}
