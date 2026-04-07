local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

autocmd('FileType', {
  pattern = '*',
  group = augroup('disable-auto-comment', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'o' })
  end,
})

autocmd('TermOpen', {
  group = augroup('disable-spell-term', { clear = true }),
  callback = function()
    vim.opt_local.spell = false
  end,
})
