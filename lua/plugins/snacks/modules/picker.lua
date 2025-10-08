local r = require
local ui = r("utils.ui")
local helper = r("plugins.snacks.helper")

return {
  focus = "input",
  ui_select = false,
  layout = {
    preset = "telescope",
    reverse = true,
    layout = {
      box = "horizontal",
      backdrop = true,
      width = 0.8,
      height = 0.9,
      border = ui.border,
      {
        box = "vertical",
        { win = "list", title = " Results ", title_pos = "center", border = ui.border },
        {
          win = "input",
          height = 1,
          border = ui.border,
          title = "{title} {live} {flags}",
          title_pos = "center",
        },
      },
      {
        win = "preview",
        title = "{preview:Preview}",
        width = 0.60,
        border = ui.border,
        title_pos = "center",
      },
    },
  },

  win = {
    input = {
      keys = {
        ["<C-d>"] = { "scroll_down", mode = { "n", "i" } },
        ["<C-u>"] = { "scroll_up",   mode = { "n", "i" } },
        ["G"] = { "scroll_to_bottom", mode = { "n" }},
        ["gg"]    = { "scroll_to_top",   mode = { "n" }},
      },
    },
    list = {
      keys = {
        ["<C-d>"] = { "scroll_down", mode = { "n", "i" } },
        ["<C-u>"] = { "scroll_up",   mode = { "n", "i" } },
        ["G"] = { "scroll_to_bottom", mode = { "n" }},
        ["gg"]    = { "scroll_to_top",   mode = { "n" }},

      },
    },
    preview = {
      keys = {
        ["<C-d>"] = { "scroll_down", mode = { "n", "i" } },
        ["<C-u>"] = { "scroll_up",   mode = { "n", "i" } },
        ["G"] = { "scroll_to_bottom", mode = { "n" }},
        ["gg"]    = { "scroll_to_top",   mode = { "n" }},
      },
    },
  },

  actions = {
    scroll_down = function(picker)
      helper.picker.scroll_handler(picker, false)
    end,
    scroll_up = function(picker)
       helper.picker.scroll_handler(picker, true)
    end,
    scroll_to_bottom = function(picker)
      helper.picker.scroll_to_handle(picker, false, picker:count() -1)
    end,
    scroll_to_top = function(picker)
      helper.picker.scroll_to_handle(picker, true, picker:count() -1)
    end,
  },
}
