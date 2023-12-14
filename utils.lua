local M = {}

-- stylua: ignore
function M.is_win()
  return vim.loop.os_uname().sysname:find("Windows", 1, true) ~= nil
end

return M
