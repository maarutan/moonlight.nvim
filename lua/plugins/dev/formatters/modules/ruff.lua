local r = require
local U = r("plugins.dev.formatters.helper")

return {
    format = function()
        return U.make(
            "ruff",
            { "format", "--stdin-filename" },
            true,  -- use_bufname
            true   -- stdin
        )
    end,
}
