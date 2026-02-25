-- Несколько курсоров
return {
  'jake-stewart/multicursor.nvim',
  event = 'VeryLazy',

  config = function()
    local mc = require('multicursor-nvim')
    mc.setup()

    local map = vim.keymap.set

    map({ 'n', 'x' }, '<C-n>', function()
      mc.matchAddCursor(1)
    end, { desc = 'Add cursor on next match' })
    map({ 'n', 'x' }, '<C-p>', function()
      mc.matchAddCursor(-1)
    end, { desc = 'Add cursor on prev match' })

    map({ 'n', 'x' }, '<leader>m', mc.toggleCursor, { desc = 'Add/remove cursor' })
    map({ 'n', 'x' }, '<C-a>', mc.enableCursors, { desc = 'Activate cursors' })
    map({ 'n', 'x' }, '<C-leftmouse>', mc.handleMouse, { desc = 'Add cursor with click' })

    map({ 'n', 'x' }, '<Up>', function()
      mc.lineAddCursor(-1)
    end, { desc = 'Add cursor above' })
    map({ 'n', 'x' }, '<Down>', function()
      mc.lineAddCursor(1)
    end, { desc = 'Add cursor below' })

    map('x', 'I', mc.insertVisual, { desc = 'Insert at each line' })
    map('x', 'A', mc.appendVisual, { desc = 'Append at each line' })

    map('n', '<Esc>', function()
      if mc.hasCursors() then
        mc.clearCursors()
      else
        vim.cmd('nohlsearch')
      end
    end)
  end,
}
