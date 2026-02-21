-- Автодополнение
return {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = { 'rafamadriz/friendly-snippets' },

  opts = {
    keymap = {
      preset = 'default',
      ['<A-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },

    appearance = { nerd_font_variant = 'normal' },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
      menu = {
        draw = {
          columns = {
            { 'kind_icon', 'kind', gap = 1 },
            { 'label', 'label_description', gap = 1 },
          },
          treesitter = { 'lsp' },
        },
      },
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
    },

    signature = { enabled = true },
  },
}
