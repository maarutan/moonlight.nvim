local d = "plugins.ui.colorscheme.schemes."
local r = require

return {
  {
    "raddari/last-color.nvim",
    version = "*",
    config = function()
      local theme = require("last-color").recall() or "default"
      vim.cmd.colorscheme(theme)
    end,
  },

  { r(d .. "vscode") },
  { r(d .. "rose_pine") },
  { r(d .. "catppuccin") },
  { r(d .. "gruvbox") },
  { r(d .. "kanagawa") },
  { r(d .. "tokyonight") },
  { r(d .. "everforest") },
  { r(d .. "dracula") },
  { r(d .. "solarized_osaka") },
  { r(d .. "cyberdream") },
}
