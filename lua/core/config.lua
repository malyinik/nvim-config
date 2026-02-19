-- Машинозависимые настройки со значениями по умолчанию.
-- Файл lua/config_local.lua переопределяет их и не коммитится в репозиторий.

local M = {
  -- Пути к интерпретаторам
  python_path = 'python3',

  -- Форматтеры
  tex_fmt_config = nil,
}

-- Попытка загрузить локальные переопределения
local ok, overrides = pcall(require, 'config_local')
if ok and type(overrides) == 'table' then
  M = vim.tbl_deep_extend('force', M, overrides)
end

return M
