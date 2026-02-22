-- GitHub Copilot
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',

  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<M-CR>',
        accept_word = '<M-w>',
        accept_line = '<M-l>',
      },
    },
    panel = {
      keymap = { open = false },
    },
  },
}
