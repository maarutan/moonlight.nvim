local r = require
local U = r("plugins.dev.formatters.helper")

return {
    format = function()
        return U.make(
            "rustfmt",
            nil,          -- no extra args
            true,         -- use current buffer name
            false,        -- no stdin, rustfmt works on file directly
            function()    -- pre_hook: refresh buffer after formatting
                vim.cmd("edit!")
                vim.cmd("normal! zz")
            end
        )
    end,
}
