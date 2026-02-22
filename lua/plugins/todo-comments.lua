-- Подсветка TODO, FIXME, HACK, NOTE и т.д. и поиск по ним
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },

  keys = {
    { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Search TODOs' },
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next TODO',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Prev TODO',
    },
  },

  opts = {},
}
