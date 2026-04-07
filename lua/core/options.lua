vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.winborder = 'rounded'
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Отступы и перенос строк
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.breakindent = true
vim.o.linebreak = true

-- Поиск
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

-- Сплиты и навигация
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 10
vim.o.mouse = 'a'
vim.o.jumpoptions = 'view'

-- Фолдинг
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99

-- Разное
vim.o.undofile = true
vim.o.updatetime = 400
vim.o.timeoutlen = 500
vim.o.confirm = true
vim.o.spell = true
vim.o.spelllang = 'en,ru'

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.opt.langmap =
  'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
