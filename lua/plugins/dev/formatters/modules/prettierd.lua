local r = require
local U = r("plugins.dev.formatters.helper")

return {
    format = function()
        local config = U.config_path("cfg/.prettierrc")
        return U.make(
            "prettierd",
            { "--config", config },
            true,  -- use_bufname
            true   -- stdin
        )
    end,
}
