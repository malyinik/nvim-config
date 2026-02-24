return {
  {
    -- Нижняя строка состояния
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      require('lualine').setup({})
    end,
  },

  {
    -- Отображения открытых буферов в виде вкладок
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',

    opts = {
      vim.keymap.set('n', '<leader>blp', ':BufferLinePick<CR>', { desc = 'Pick buffer' }),
      vim.keymap.set('n', '<leader>blc', ':BufferLinePickClose<CR>', { desc = 'Close picked buffer' }),
    },

    config = function()
      local bufferline = require('bufferline')
      bufferline.setup({
        options = {
          mode = 'tabs', -- set to "tabs" to only show tabpages instead
          diagnostics = 'nvim_lsp',
          separator_style = 'thick',
        },
      })
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup({
        shortcut_type = 'letter', -- shortcut type 'letter' or 'number'
        config = {
          header = {}, -- header
          week_header = {
            enable = true, --boolean use a week header
          },
          disable_move = true, -- boolean default is false disable move key

          shortcut = {
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Grep',
              group = 'Number',
              action = 'Telescope live_grep',
              key = 'g',
            },
            {
              desc = ' Sessions',
              group = 'DiagnosticHint',
              action = 'AutoSession search',
              key = 's',
            },
          },

          packages = { enable = true }, -- show how many plugins neovim loaded
          project = {
            enable = true,
            limit = 8,
            icon = '󰪺 ',
            label = 'Recent projects',
            action = 'Telescope find_files cwd=',
          },
          mru = {
            enable = true,
            limit = 16,
            icon = ' ',
            label = 'Recent files',
            cwd_only = false,
          },

          footer = {}, -- footer
        },
      })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
