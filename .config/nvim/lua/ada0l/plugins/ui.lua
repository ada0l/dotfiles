return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      vim.cmd [[colorscheme rose-pine]]
    end
  },
  {
    'echasnovski/mini.statusline',
    dependencies = {
      {
        'linrongbin16/lsp-progress.nvim',
        opts = {
          client_format = function(client_name, spinner, series_messages)
            return #series_messages > 0
                and ("[" .. client_name .. "] " .. spinner) or nil
          end,
          format = function(client_messages)
            return #client_messages > 0
                and (" " .. table.concat(client_messages, " "))
                or ""
          end,
        },
      }
    },
    version = '*',
    opts = function()
      local function section_lsp_loading()
        return require('lsp-progress').progress()
      end
      ---@param args __statusline_args
      ---@return __statusline_section
      local function section_fileinfo(args)
        local filetype = vim.bo.filetype

        if filetype == '' or vim.bo.buftype ~= '' then
          return ''
        end

        if MiniStatusline.is_truncated(args.trunc_width) then
          return filetype
        end

        local encoding = vim.bo.fileencoding or vim.bo.encoding
        local format = vim.bo.fileformat

        return string.format('%s %s %s', filetype, encoding, format)
      end

      ---@param args __statusline_args
      ---@return __statusline_section
      ---@diagnostic disable-next-line: unused-local
      local function section_location(args)
        return '%l, %c'
      end

      return {
        content = {
          active = function()
            -- stylua: ignore start
            local mode, _     = MiniStatusline.section_mode({ trunc_width = 120 })
            local lsp_loading = section_lsp_loading()

            local git         = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })

            local filename    = MiniStatusline.section_filename({ trunc_width = 140 })

            local fileinfo    = section_fileinfo({ trunc_width = 120 })

            local location    = section_location({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
              { strings = { mode } },
              { strings = { lsp_loading } },
              '%=', -- End left alignment
              { strings = { filename } },
              '%<', -- Mark general truncate point
              '%=', -- End left alignment
              { strings = { git, diagnostics } },
              { strings = { fileinfo } },
              { strings = { location } },
            })
            -- stylua: ignore end
          end,
        },
        inactive = function()
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          return MiniStatusline.combine_groups({
            { strings = { filename } },
          })
        end,
        set_vim_settings = false,
      }
    end,
    config = function(_, opts)
      require('mini.statusline').setup(opts)
      local set_active = function() vim.wo.statusline = '%!v:lua.MiniStatusline.active()' end
      vim.api.nvim_create_autocmd("User LspProgressStatusUpdated", {
        group = "MiniStatusline",
        callback = set_active
      })
    end
  },
  {
    'echasnovski/mini.cursorword',
    enabled = false,
    version = '*',
    opts = {},
  },
  -- {
  --   'stevearc/dressing.nvim',
  --   opts = {},
  -- },
  {
    'norcalli/nvim-colorizer.lua',
    ft = 'lua',
    opts = { 'lua' },
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    opts = function()
      return {
        draw = {
          delay = 0,
          animation = require('mini.indentscope').gen_animation.none(),
        },
        mappings = {
          object_scope = 'ii',
          object_scope_with_border = 'ai',
          goto_top = '[i',
          goto_bottom = ']i',
        },
        options = {
          border = 'both',
          indent_at_cursor = true,
          try_as_border = false,
        },
        symbol = '│',
      }
    end,
  },
}
