return {
    "jake-stewart/multicursor.nvim",
    branch = "main",
    config = function()
        local map = vim.keymap.set
        local mc = require("multicursor-nvim")
        mc.setup()
        local opts = { noremap = true, silent = true }

        -- Add or skip cursor above/below the main cursor.
        map({"n", "x"}, "<C-k>",     function() mc.lineAddCursor(-1) end)
        map({"n", "x"}, "<C-j>",     function() mc.lineAddCursor(1)  end)
        map({"n", "x"}, "<C-S-k>",   function() mc.lineSkipCursor(-1)end)
        map({"n", "x"}, "<C-S-j>",   function() mc.lineSkipCursor(1) end)

        -- Add or skip adding a new cursor by matching word/selection
        map({"n", "x"}, "<C-n>",     function() mc.matchAddCursor(1) end)
        map({"n", "x"}, "<C-S-n>",     function() mc.matchAddCursor(-1)end)

        map({ "n", "x" }, "<A-n>", function() mc.matchSkipCursor(1) end)
        map({ "n", "x" }, "<A-S-n>", function() mc.matchSkipCursor(-1) end)


        -- Mouse
        map("n", "<C-LeftMouse>",    mc.handleMouse)
        map("n", "<C-LeftDrag>",     mc.handleMouseDrag)
        map("n", "<C-LeftRelease>",  mc.handleMouseRelease)

        -- Toggle cursors
        map({"n","x"}, "<C-m>",      mc.toggleCursor)

        -- Layer-keymaps for when multiple cursors active
        mc.addKeymapLayer(function(layerSet)
            layerSet({"n","x"}, "<Left>",   mc.prevCursor)
            layerSet({"n","x"}, "<Right>",  mc.nextCursor)
            layerSet({"n","x"}, "<C-x>",    mc.deleteCursor)

            layerSet("n","<Esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        map("n", "<C-A-a>",  mc.searchAllAddCursors)

        -- Highlight groups
        local hl = vim.api.nvim_set_hl
        hl(0,"MultiCursorCursor",          { reverse = true })
        hl(0,"MultiCursorVisual",          { link = "Visual" })
        hl(0,"MultiCursorSign",            { link = "SignColumn" })
        hl(0,"MultiCursorMatchPreview",    { link = "Search" })
        hl(0,"MultiCursorDisabledCursor",  { reverse = true })
        hl(0,"MultiCursorDisabledVisual",  { link = "Visual" })
        hl(0,"MultiCursorDisabledSign",    { link = "SignColumn" })
    end
}
