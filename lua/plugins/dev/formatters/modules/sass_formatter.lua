local r = require
local U = r("plugins.dev.formatters.helper")

return {
    format = function()
        return U.make(
            "sass-formatter",
            {
                "--config",
                U.config_path("cfg/.sassformatterrc.json"),
                "-w",
            },
            true,          -- use current buffer path
            false,         -- no stdin, it writes directly to file
            function()     -- pre_hook: reload and center buffer after formatting
                vim.cmd("edit!")
                vim.cmd("normal! zz")
            end
        )
    end,
}
