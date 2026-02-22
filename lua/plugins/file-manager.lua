return {
  {
    -- Файловый менеджер: редактирование файловой системы как буфер
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },

    keys = {
      { '-', '<cmd>Oil --float<cr>', desc = 'Open file manager' },
    },

    opts = {
      columns = { 'icon' },
      watch_for_changes = true,
      keymaps = {
        ['<BS>'] = 'actions.parent',
        ['-'] = 'actions.close',
      },
    },
  },
  {
    'benomahony/oil-git.nvim',
    dependencies = { 'stevearc/oil.nvim' },
  },
  {
    'JezerM/oil-lsp-diagnostics.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },

  {
    -- Дерево файлов проекта
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },

    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'File tree' },
    },

    opts = {},
  },
}
