local r = require
local nt = r("neo-tree")
local manager = r("neo-tree.sources.manager")
local commands = r("neo-tree.sources.common.commands")
local Trash_cli = r("utils.trash_cli")
local inputs = require("neo-tree.ui.inputs")

-- создаём экземпляр Trash_cli
local trash = Trash_cli:new()

return {
    none = function() return nil end,

    visual_line = function(state)
      vim.cmd("normal! V")
    end,

    toggle_hide_root_node = function(state)
      local cfg = nt.config
      cfg.hide_root_node = not cfg.hide_root_node
      manager.refresh(state)
    end,

    copy_file_name = function(state)
      local node = state.tree:get_node()
      if not node then return end
      vim.fn.setreg("+", node.name)
    end,

    copy_file_path = function(state)
      local node = state.tree:get_node()
      if not node then return end
      vim.fn.setreg("+", node.path)
    end,

    copy_dir_path = function(state)
      local node = state.tree:get_node()
      if not node then return end
      local path = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
      vim.fn.setreg("+", path)
    end,

    copy_filename_without_ext = function(state)
      local node = state.tree:get_node()
      if not node or node.type ~= "file" then return end
      local name = vim.fn.fnamemodify(node.path, ":t:r")
      vim.fn.setreg("+", name)
    end,

    smart_enter = function(state)
      local node = state.tree:get_node()
      if not node then return end
      if node.type == "directory" then
        state.commands["toggle_node"](state)
      else
        state.commands["open"](state)
      end
    end,

    put_trash = function(state)
      local node = state.tree:get_node()
      if not node then return end

      local msg = string.format("Move '%s' to trash?", node.name)
      inputs.confirm(msg, function(confirmed)
        if not confirmed then return end
        trash:put(node.path)
        manager.refresh(state)
      end)
    end,

    restore_from_trash = function(state)
      local last_item = trash:last_restorable_name() or "unknown"
      local msg = string.format("Restore '%s' from trash?", last_item)
      inputs.confirm(msg, function(confirmed)
        if not confirmed then return end
        trash:restore()
        manager.refresh(state)
      end)
    end,
}
