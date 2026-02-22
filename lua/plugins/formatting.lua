-- Форматирование: format on save, внешние форматтеры
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = { 'ConformInfo' },

  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      python = { 'ruff_format' },
      json = { 'jq' },
      yaml = { 'yamlfmt' },
      markdown = { 'prettier' },
      bash = { 'shfmt' },
      sh = { 'shfmt' },
      cmake = { 'gersemi' },
      typst = { 'typstyle' },
      tex = { 'tex-fmt' },
      sql = { 'pg_format', 'sleek' },
    },

    formatters = {
      ['clang-format'] = {
        args = { '--style=file' },
      },
      ['typstyle'] = {
        args = { '--column', '120', '--tab-width', '4' },
      },
      ['tex-fmt'] = function()
        local config = require('core.config')
        return {
          args = config.tex_fmt_config and { '--config', config.tex_fmt_config, '--stdin' } or { '--stdin' },
        }
      end,
      ['pg_format'] = {
        args = { '--format-type', '--no-extra-line' },
      },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}
