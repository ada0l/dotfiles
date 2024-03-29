local function diagnostic_format(diagnostic)
  if diagnostic.code then
    return ('[%s] %s'):format(diagnostic.code, diagnostic.message)
  end
  return diagnostic.message
end

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      --{ 'hrsh7th/cmp-nvim-lsp' },
    },
    opts = {
      capabilities = {},
      autoformat = {},
      servers = {},
      setup = {},
    },
    config = function(_, opts)
      vim.diagnostic.config({
        virtual_text = {
          source = 'always',
          format = diagnostic_format,
        },
        float = {
          source = 'always',
          format = diagnostic_format,
        },
      })

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend(
        'force',
        {
            completionProvider = {
              triggerCharacters = { '.', ':' }
            }
        },
        vim.lsp.protocol.make_client_capabilities(),
        ---require('cmp_nvim_lsp').default_capabilities(),
        opts.capabilities or {}
      )
      require('ada0l.utils').on_attach(function(client, buffer)
        require('ada0l.plugins.lsp.keymaps').on_attach(client, buffer)
      end)

      local function setup_server(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        require('lspconfig')[server].setup(server_opts)
      end

      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
      end
      local ensure_installed = {}

      for server, server_opts in pairs(servers) do
        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
          setup_server(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = ensure_installed,
          handlers = { setup_server },
        })
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
