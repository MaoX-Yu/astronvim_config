-- set vim options here (vim.<first_key>.<second_key> = value)
local options = {
  opt = {
    -- set to true or false etc.
    mouse = "",
    number = true, -- sets vim.opt.number
    relativenumber = true, -- sets vim.opt.relativenumber
    scrolloff = 8,
    sidescrolloff = 8,
    spell = false, -- sets vim.opt.spell
    signcolumn = "yes", -- sets vim.opt.signcolumn to auto
    wrap = false, -- sets vim.opt.wrap
  },
  g = {
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    autopairs_enabled = true, -- enable autopairs at start
    cmp_enabled = true, -- enable completion at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    mapleader = " ", -- sets vim.g.mapleader
    resession_enabled = false, -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
  },
}
-- If you need more control, you can use the function()...end notation
return function(local_vim)
  local_vim.opt.listchars = vim.opt.listchars + "space:·"

  -- windows settings
  if require("user.utils").is_windows() then
    -- local_vim.opt.shell = "pwsh"
  end
  
  for scope, table in pairs(options) do
    for setting, value in pairs(table) do
      local_vim[scope][setting] = value
    end
  end

  return local_vim
end
