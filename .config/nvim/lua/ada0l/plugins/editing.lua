return {
  {
    'echasnovski/mini.pairs',
    version = '*',
    lazy = true,
    event = { 'InsertEnter' },
    opts = {},
    init = function()
      vim.cmd([[autocmd Filetype TelescopePrompt lua vim.b.minipairs_disable = true]])
    end,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    keys = {
      { "ms", mode = { 'x', 'v', 'n' }, desc = "[Match] Surround add" },
      { "md", mode = { 'n', 'x', 'v' }, desc = "[Match] Surround delete" },
      { "mr", mode = { 'n' },           desc = "[Match] Surround replace" },
      { "mf", mode = { 'n' },           desc = "[Match] Surround find" },
    },
    opts = {
      mappings = {
        add = 'ms',
        delete = 'md',
        replace = 'mr',
        find = 'mf',
      },
      search_method = 'cover_or_next',
    },
  },
  {
    'echasnovski/mini.splitjoin',
    version = '*',
    lazy = true,
    keys = { { 'gS', desc = "[Splitjoin] toggle" } },
    opts = {
      mappings = {
        toggle = 'gS',
        split = '',
        join = '',
      },
    },
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    keys = {
      { '<c-c>', mode = { 'n', 'v', 'x' }, desc = "[Comment] toggle" }
    },
    opts = {
      mappings = {
        comment = '<c-c>',
        comment_line = '<c-c>',
        textobject = 'gc',
      },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    keys = {
      {
        '<leader>?',
        function()
          require('spectre').open()
        end,
        desc = '[Spectre] Open',
      },
    },
    opts = {},
  },
  {
    'gpanders/editorconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'echasnovski/mini.doc',
    version = '*',
    opts = {},
  },
}
