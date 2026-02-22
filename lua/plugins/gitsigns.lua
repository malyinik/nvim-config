-- Git: знаки изменений в signcolumn, blame, операции с hunks
return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',

  opts = {
    on_attach = function(bufnr)
      local gs = require('gitsigns')
      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'Git: ' .. desc })
      end

      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gs.nav_hunk('next')
        end
      end, 'Next hunk')

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gs.nav_hunk('prev')
        end
      end, 'Prev hunk')

      map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
      map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
      map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
      map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo stage hunk')
      map('n', '<leader>gb', gs.blame_line, 'Blame line')
      map('n', '<leader>gB', gs.toggle_current_line_blame, 'Toggle line blame')
      map('n', '<leader>gd', gs.diffthis, 'Diff against index')
    end,
  },
}
