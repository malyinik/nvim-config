-- Автоматическое сохранение и восстановление сессий
return {
  'rmagatti/auto-session',
  lazy = false,

  keys = {
    { '<leader>wr', '<cmd>AutoSession search<CR>', desc = 'Session search' },
    { '<leader>ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
    { '<leader>wa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
    { '<leader>wd', '<cmd>AutoSession delete<CR>', desc = 'Delete session' },
  },

  opts = {
    suppressed_dirs = { '~/', '~/Downloads', '~/Desktop', '/tmp' },
  },
}
