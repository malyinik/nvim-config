-- LSP: языковые серверы, автоустановка, диагностика
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
  },
  config = function()
    local config = require('core.config')

    require('mason-lspconfig').setup({
      ensure_installed = {
        'clangd',
        'pyright',
        'lua_ls',
        'bashls',
        'neocmake',
        'yamlls',
        'tinymist',
        'jsonls',
        'marksman',
      },
      automatic_enable = true,
    })

    -- Кеймапы при подключении LSP к буферу
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local builtin = require('telescope.builtin')
        map('grd', builtin.lsp_definitions, 'Go to definition')
        map('grD', vim.lsp.buf.declaration, 'Go to declaration')
        map('grr', builtin.lsp_references, 'Find references')
        map('gri', builtin.lsp_implementations, 'Go to implementation')
        map('grt', builtin.lsp_type_definitions, 'Go to type definition')
        map('grs', builtin.lsp_document_symbols, 'Document symbols')
        map('grS', builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols')
        map('grl', vim.diagnostic.open_float, 'Line diagnostics')

        -- Переключение inlay hints
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, 'Toggle inlay hints')
        end
      end,
    })

    -- Диагностика
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '●',
          [vim.diagnostic.severity.WARN] = '●',
          [vim.diagnostic.severity.INFO] = '●',
          [vim.diagnostic.severity.HINT] = '●',
        },
      },
      virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
      float = { source = true },
      severity_sort = true,
    })

    -- Подсветка ссылок на символ под курсором
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-highlight', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client or not client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          return
        end

        local highlight_group = vim.api.nvim_create_augroup('lsp-highlight-' .. event.buf, { clear = true })

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('lsp-highlight-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = 'lsp-highlight-' .. event2.buf })
          end,
        })
      end,
    })

    -- Переопределения серверов с пользовательскими настройками

    vim.lsp.config('clangd', {
      cmd = { 'clangd', '--clang-tidy', '--log=error' },
      capabilities = { offsetEncoding = { 'utf-16' } },
    })

    vim.lsp.config('pyright', {
      settings = {
        python = {
          pythonPath = config.python_path,
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME .. '/lua' },
          },
          completion = { callSnippet = 'Replace' },
        },
      },
    })

    vim.lsp.config('sqls', {
      cmd = { 'sqls' },
      settings = {
        sqls = {
          connections = config.sqls_connections or {},
        },
      },
    })
  end,
}
