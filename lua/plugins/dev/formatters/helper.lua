-- lua/utils/formatter_util.lua
local U = {}
local r = require
local which = r("utils.which")

--- @param exe string
--- @param extra_args table|string|nil
--- @param use_bufname boolean|nil
--- @param stdin boolean|nil
--- @param pre_hook fun()|nil
function U.make(exe, extra_args, use_bufname, stdin, pre_hook)
    if not which:is_exists(exe) then
        return nil
    end

    local args = {}

    if extra_args then
        if type(extra_args) == "string" then
            table.insert(args, extra_args)
        else
            vim.list_extend(args, extra_args)
        end
    end

    if use_bufname then
        table.insert(args, vim.api.nvim_buf_get_name(0))
    end

    return {
        exe = exe,
        args = args,
        stdin = stdin ~= false,
        pre_hook = pre_hook,
    }
end

--- @param relative string
function U.config_path(relative)
    local script_path = debug.getinfo(2, "S").source:sub(2):match("(.*/)")
    return script_path .. relative
end

return U
