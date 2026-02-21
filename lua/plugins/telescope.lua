-- Fuzzy-поиск по файлам, буферам, LSP, grep и т.д.
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'nvim-telescope/telescope-project.nvim' },
    { 'debugloop/telescope-undo.nvim' },
  },
  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        layout_strategy = 'flex',
        layout_config = {
          width = 0.9,
          height = 0.9,
          flip_columns = 120,
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
        file_ignore_patterns = {
          '%.git/',
          'node_modules/',
          'build/',
          'dist/',
          '__pycache__/',
          '%.o$',
          '%.pyc$',
          '%.DS_Store',
        },
        mappings = {
          n = {
            ['dd'] = actions.delete_buffer,
            ['s'] = actions.select_vertical,
            ['S'] = actions.select_horizontal,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        undo = {
          side_by_side = true,
          mappings = {
            i = {
              ['<cr>'] = require('telescope-undo.actions').restore,
              ['<C-y>'] = require('telescope-undo.actions').yank_additions,
              ['<C-d>'] = require('telescope-undo.actions').yank_deletions,
            },
            n = {
              ['u'] = require('telescope-undo.actions').restore,
              ['y'] = require('telescope-undo.actions').yank_additions,
              ['Y'] = require('telescope-undo.actions').yank_deletions,
            },
          },
        },
      },
    })

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'project')
    pcall(require('telescope').load_extension, 'undo')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search resume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search recent files' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search select Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'Search marks' })
    vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = 'Search jumps' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy search in buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep({ grep_open_files = true, prompt_title = 'Live Grep in Open Files' })
    end, { desc = 'Search in open files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = 'Search Neovim files' })

    vim.keymap.set('n', '<leader>sp', require('telescope').extensions.project.project, { desc = 'Search projects' })
    vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>', { desc = 'Search undo history' })

    vim.keymap.set('n', '<leader>sF', function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = 'Search all files (hidden)' })

    vim.keymap.set('n', '<leader>sG', function()
      builtin.live_grep({ additional_args = { '--hidden', '--no-ignore' } })
    end, { desc = 'Grep all files (hidden)' })
  end,
}
