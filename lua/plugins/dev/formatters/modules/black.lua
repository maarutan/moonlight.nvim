local r = require
local U = r("plugins.dev.formatters.helper")

return {
    format = function()
        return U.make(
            "black",
            { "-" },
            false,
            true 
        )
    end,
}
