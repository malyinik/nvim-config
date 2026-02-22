-- Типы и автодополнение Neovim API для lua_ls
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  -- Типы для vim.uv
  { 'Bilal2453/luvit-meta', lazy = true },
}
