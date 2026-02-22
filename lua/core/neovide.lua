if vim.g.neovide then
  vim.g.neovide_input_macos_option_key_is_meta = 'both'
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_fullscreen = false
  vim.g.neovide_cursor_animation_length = 0.25

  vim.o.guifont = 'JetBrainsMonoNL Nerd Font Mono:h14'

  vim.keymap.set('n', '<A-CR>', function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end)

  vim.keymap.set('n', '<C-=>', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end)

  vim.keymap.set('n', '<C-->', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
  end)

  vim.keymap.set('n', '<C-0>', function()
    vim.g.neovide_scale_factor = 1.0
  end)
end
