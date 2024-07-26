-- ~/.config/nvim/lua/todos.lua
local M = {}

-- ファイルパスを指定
local todos_file = vim.fn.expand('~/.todos')

-- 一番上のToDoを取得する関数
function M.get_top_todo()
  local file = io.open(todos_file, "r")
  if not file then
    return "No ToDos"
  end

  local top_todo = file:read("*l")
  file:close()

  return top_todo or "No ToDos"
end

return M

