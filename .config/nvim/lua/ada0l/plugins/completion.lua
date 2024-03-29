return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp',                lazy = true },
      { 'hrsh7th/cmp-path',                    lazy = true },
      { 'hrsh7th/cmp-cmdline',                 lazy = true },
      { 'hrsh7th/cmp-vsnip',                   lazy = true },
      { 'hrsh7th/vim-vsnip',                   lazy = true },
      { 'rafamadriz/friendly-snippets',        lazy = true },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', lazy = true },
      { 'onsails/lspkind.nvim',                lazy = true },
    },
    opts = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end
      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      return {
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
          -- completion = {
          --   winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          --   scrollbar = true,
          --   col_offset = -3,
          --   side_padding = 0,
          -- },
          -- documentation = {
          --   winhighlight = 'Normal:CmpDoc',
          -- },
        },
        performance = {
          debounce = 50,
          fetching_timeout = 100,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            end
          end, { 'i', 's' }),
          ['<C-j>'] = cmp.mapping(function(fallback)
            if vim.fn['vsnip#available'](1) == 1 then
              feedkey('<Plug>(vsnip-expand-or-jump)', '')
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-k>'] = cmp.mapping(function()
            if vim.fn['vsnip#jumpable'](-1) == 1 then
              feedkey('<Plug>(vsnip-jump-prev)', '')
            end
          end, { 'i', 's' }),
        }),

        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp_signature_help', group_index = 1 },
          { name = 'vsnip',                   max_item_count = 5, group_index = 1 },
          { name = 'nvim_lsp',                group_index = 1 },
          { name = 'nvim_lua',                group_index = 1 },
          { name = 'path',                    group_index = 2 },
          { name = 'obsidian',                group_index = 2 },
        }),
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
              mode = 'symbol_text',
              maxwidth = 50,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, '%s', { trimempty = true })
            kind.kind = ' ' .. (strings[1] or '') .. ' '
            kind.menu = '    (' .. (strings[2] or '') .. ')'

            return kind
          end,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require('cmp')
      cmp.setup(opts)

      cmp.register_source('obsidian', require('obsidian').get_cmp_source().new())

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },
  -- {
  --   'echasnovski/mini.completion',
  --   dependencies = {
  --     {
  --       'echasnovski/mini.fuzzy',
  --       version = '*',
  --       opts = {}
  --     },
  --   },
  --   version = '*',
  --   opts = function()
  --     return {
  --       delay = { completion = 100, info = 100, signature = 50 },
  --       window = {
  --         info = { height = 25, width = 80, border = 'single' },
  --         signature = { height = 25, width = 80, border = 'single' },
  --       },
  --       lsp_completion = {
  --         source_func = 'omnifunc',
  --         auto_setup = false,
  --         process_items = function(items, base)
  --           items = vim.tbl_filter(function(item)
  --             return item.kind ~= 15 and item.kind ~= 1
  --           end, items)
  --
  --           return MiniFuzzy.process_lsp_items(items, base)
  --         end
  --       },
  --       set_vim_settings = false
  --     }
  --   end
  -- },
}
