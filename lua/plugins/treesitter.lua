return {
  -- Подсветка, индентация и фолдинг на основе AST-парсинга
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',

  dependencies = {
    -- select/move/swap для функций, классов, аргументов, циклов
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  config = function()
    require('nvim-treesitter').setup({})

    -- Автоустановка парсеров при первом запуске
    local ensure_installed = {
      'c',
      'cpp',
      'python',
      'bash',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
      'query',
      'diff',
      'regex',
      'json',
      'yaml',
      'toml',
    }

    local installed = require('nvim-treesitter').get_installed()
    for _, parser in ipairs(ensure_installed) do
      if not vim.tbl_contains(installed, parser) then
        require('nvim-treesitter').install(parser)
      end
    end

    -- Подсветка + автоустановка парсера при открытии файла
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        local installed = require('nvim-treesitter').get_installed()
        if vim.tbl_contains(installed, lang) then
          vim.treesitter.start(args.buf)
        elseif vim.tbl_contains(require('nvim-treesitter').get_available(), lang) then
          require('nvim-treesitter').install(lang)
        end
      end,
    })

    -- Индентация через treesitter (кроме c/cpp/ruby)
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        local disabled = { c = true, cpp = true, ruby = true }
        if not disabled[vim.bo.filetype] then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- Textobjects
    require('nvim-treesitter-textobjects').setup({
      select = { lookahead = true },
      move = { set_jumps = true },
    })

    local select_maps = {
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
      ['al'] = '@loop.outer',
      ['il'] = '@loop.inner',
    }
    for key, query in pairs(select_maps) do
      vim.keymap.set({ 'x', 'o' }, key, function()
        require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
      end)
    end

    local move_next = {
      [']f'] = '@function.outer',
      [']c'] = '@class.outer',
      [']a'] = '@parameter.inner',
      [']l'] = '@loop.outer',
    }
    local move_prev = {
      ['[f'] = '@function.outer',
      ['[c'] = '@class.outer',
      ['[a'] = '@parameter.inner',
      ['[l'] = '@loop.outer',
    }
    for key, query in pairs(move_next) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function()
        require('nvim-treesitter-textobjects.move').goto_next_start(query, 'textobjects')
      end)
    end
    for key, query in pairs(move_prev) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function()
        require('nvim-treesitter-textobjects.move').goto_previous_start(query, 'textobjects')
      end)
    end

    vim.keymap.set('n', '<leader>a', function()
      require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
    end)
    vim.keymap.set('n', '<leader>A', function()
      require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
    end)
  end,
}
