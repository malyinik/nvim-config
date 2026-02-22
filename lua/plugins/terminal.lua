-- Терминал внутри Neovim
return {
  'akinsho/toggleterm.nvim',
  version = '*',

  keys = {
    { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal' },
    { '<C-\\>', '<cmd>ToggleTerm<cr>', mode = 't', desc = 'Toggle terminal' },
  },

  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = '<C-\\>',
    direction = 'tab',
    autochdir = true,
    float_opts = { border = 'rounded' },
  },
}
