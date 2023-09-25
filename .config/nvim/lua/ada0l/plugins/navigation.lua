return {
  {
    'echasnovski/mini.files',
    keys = {
      {
        '<leader>n',
        function()
          require('mini.files').open()
        end,
        desc = '[Files] Toggle',
      },
      {
        '<leader>N',
        function()
          require('mini.files').open(vim.api.nvim_buf_get_name(0))
        end,
        desc = '[Files] Toggle current file',
      },
    },
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 70,
      }
    },
  },
  {
    'echasnovski/mini.jump2d',
    version = '*',
    keys = {
      '<CR>'
    },
    opts = {
      mappings = {
        start_jumping = '<CR>',
      },
      labels = 'asdfghjkl;',
      silent = false,
      view = {
        dim = false,
      },
      allowed_windows = {
        current = true,
        not_current = false,
      },
    },
    config = function(_, opts)
      vim.cmd([[au FileType * if index(['qf', 'minifiles'], &ft) < 0 | let b:minicursorword_disable=v:true | endif]])
      require('mini.jump2d').setup(opts)
    end,
  },
  {
    'ahmedkhalf/project.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>\\',
        function()
          local project_nvim = require("project_nvim")
          local recent_projects = project_nvim.get_recent_projects()
          vim.ui.select(recent_projects, {
          }, function(path)
            print(require("project_nvim.project").set_pwd(path, 'global'))
          end)
        end,
        desc = '[FZF] Search project'
      },
    },
    opts = {
      detection_methods = { 'pattern' },
      patterns = { '.git', 'Makefile', 'package.json', 'pyproject.toml' },
      silent_chdir = false,
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = 'VeryLazy',
    keys = {
      { '<leader>f', ':FzfLua files<CR>',                 desc = '[FZF] Search files' },
      { '<leader>F', ':FzfLua git_files<CR>',             desc = '[FZF] Search git files' },
      { '<leader>/', ':FzfLua live_grep_glob<CR>',        desc = '[FZF] Search by live grep' },
      { '<leader>b', ':FzfLua buffers<CR>',               desc = '[FZF] Search buffer' },
      { '<leader>d', ':FzfLua diagnostic_workspace<CR>',  desc = '[FZF] Search diagnostics in workspace' },
      { '<leader>D', ':FzfLua diagnostic_document<CR>',   desc = '[FZF] Search diagnostics in document' },
      { "<leader>'", ':FzfLua resume<CR>',                desc = '[FZF] Resume Picker' },
      { '<leader>S', ':FzfLua lsp_workspace_symbols<CR>', desc = '[FZF] Search symbol' },
      { '<leader>s', ':FzfLua lsp_document_symbols<CR>',  desc = '[FZF] Search symbol in workspace' },
    },
    opts = {},
    config = function(_, opts)
      local fzf = require('fzf-lua')
      fzf.setup(opts)
      fzf.register_ui_select()
    end
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true, icons = false },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "[Trouble] Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "[Trouble] Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "[Trouble] Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "[Trouble] Quickfix List (Trouble)" },
      {
        "[q",
        function()
          require("trouble").previous({ skip_groups = true, jump = true })
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  }
}
