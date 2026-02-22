-- Подсказки клавиш при нажатии leader и других префиксов
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',

  opts = {
    preset = 'modern',
    spec = {
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>bl', group = 'Bufferline' },
      { '<leader>g', group = 'Git' },
      { '<leader>w', group = 'Session' },
      { 'gr', group = 'LSP' },
      { ']', group = 'Next' },
      { '[', group = 'Prev' },
    },
  },
}
