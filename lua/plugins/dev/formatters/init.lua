local r = require
local m = "plugins.dev.formatters.modules"

local prettier       = r(m .. ".prettier")
local prettierd      = r(m .. ".prettierd")
local sass_formatter = r(m .. ".sass_formatter")
local alejandra      = r(m .. ".alejandra")
local beautysh       = r(m .. ".beautysh")
local rustfmt        = r(m .. ".rustfmt")
local stylua         = r(m .. ".stylua")
local ruff           = r(m .. ".ruff")
local black          = r(m .. ".black")
local clang_format   = r(m .. ".clang_format")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
  "mhartington/formatter.nvim",
  event = "VeryLazy",
  version = "*",

  opts = {
    filetype = {
      ---------------  -- Prettier
      javascript        = { prettier.format },
      typescript        = { prettier.format },
      typescriptreact   = { prettier.format },
      javascriptreact   = { prettier.format },
      html              = { prettier.format },
      htmldjango        = { prettier.format },
      css               = { prettier.format },
      scss              = { prettier.format },
      json              = { prettier.format },
      jsonc             = { prettier.format },
      markdown          = { prettier.format },

      ----------        -- Ruff
      python            = { ruff.format },
      -- python         = { black.format }, 

      ----------        -- Stylua
      lua               = { stylua.format },

      ----------        -- Beautysh
      sh                = { beautysh.format },
      bash              = { beautysh.format },
      zsh               = { beautysh.format },

      ----------        -- C / C++
      c                 = { clang_format.format },
      cpp               = { clang_format.format },

      ----------        -- Nix
      nix               = { alejandra.format },

      ----------        -- Rust
      rust              = { rustfmt.format },

      ----------        -- Sass
      sass              = { sass_formatter.format },
    },
  },

  config = function(_, opts)
    r("formatter").setup(opts)

    local group = augroup("__formatter__", { clear = true })
    autocmd("BufWritePost", {
      group = group,
      command = ":FormatWrite",
    })

    autocmd("BufWritePost", {
      pattern = "*",
      callback = function()
        vim.cmd("normal! zz")
      end,
    })
  end,
}
