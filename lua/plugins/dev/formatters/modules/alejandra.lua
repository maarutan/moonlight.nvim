local r = require
local U = r("plugins.dev.formatters.helper")

return {
    format = function()
        return U.make(
            "alejandra",
            nil,
            true,
            false,
            function()
                local filepath = vim.api.nvim_buf_get_name(0)
                vim.fn.jobstart({ "alejandra", filepath }, {
                    on_exit = function()
                        vim.schedule(function()
                            vim.cmd("edit!")
                        end)
                    end,
                })
            end
        )
    end,
}
