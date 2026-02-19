return {
  {
    -- Удобное переключение между темами
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup({
        themes = {
          'tokyonight',
          'nightfox',
          'catppuccin-mocha',
          'kanso',
          'gruvbox',
        },
      })
    end,
  },

  {
    'folke/tokyonight.nvim',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup({
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      })
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require('nightfox').setup({
        options = {
          transparent = false, -- Disable setting background
        },
      })
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },
  {
    'webhooked/kanso.nvim',
  },
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require('gruvbox').setup({
        contrast = 'hard', -- can be "hard", "soft" or empty string
      })
    end,
  },
}
