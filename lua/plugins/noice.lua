return {
  {
    -- Улучшенные уведомления
    'rcarriga/nvim-notify',
    opts = {
      timeout = 3000,
      render = 'wrapped-compact',
    },
  },

  {
    -- Улучшенная командная строка, уведомления и сообщения
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },

    opts = {
      presets = {
        lsp_doc_border = true,
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
    },
  },
}
