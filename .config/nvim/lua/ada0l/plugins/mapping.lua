return {
  {
    'Wansmer/langmapper.nvim',
    lazy = false,
    enabled = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    opts = {},
    config = function(_, opts)
      require('langmapper').setup(opts)
      require('langmapper').hack_get_keymap()
    end,
  },
  {
    'echasnovski/mini.clue',
    version = false,
    opts = function()
      local miniclue = require('mini.clue')
      return {
        clues = {
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows({ submode_resize = true }),
          miniclue.gen_clues.z(),
        },

        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- 'mini.bracketed'
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
          { mode = 'x', keys = '[' },
          { mode = 'x', keys = ']' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        window = {
          delay = 200,
          config = {
            width = 60,
            border = 'single'
          }
        },
      }
    end
  },
  -- {
  --   'folke/which-key.nvim',
  --   enabled = true,
  --   keys = { '<leader>', '[', ']', 's', 'g', 'm', '<c>' },
  --   opts = {},
  -- },
}
