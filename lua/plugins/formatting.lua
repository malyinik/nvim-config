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
      bash = { 'shfmt' },
      c = { 'clang-format' },
      cmake = { 'gersemi' },
      cpp = { 'clang-format' },
      json = { 'jq' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      python = { 'ruff_format' },
      rust = { 'rustfmt' },
      sh = { 'shfmt' },
      sql = { 'pg_format', 'sleek' },
      tex = { 'tex-fmt' },
      typst = { 'typstyle' },
      yaml = { 'yamlfmt' },
    },

    formatters = {
      ['clang-format'] = {
        args = { '--style=file' },
      },
      ['typstyle'] = {
        args = { '--column', '120', '--tab-width', '2' },
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
