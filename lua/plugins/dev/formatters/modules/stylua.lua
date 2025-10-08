local r = require
local U = r("plugins.dev.formatters.helper")

return {
    format = function()
        return U.make(
            "stylua",
            {
                "--stdin-filepath",
                vim.api.nvim_buf_get_name(0),
                "-",
            },
            false,
            true
        )
    end,
}
