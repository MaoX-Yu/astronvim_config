return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = function(_, opts)
      opts.integrations.noice = true
      return opts
    end,
  },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.pack.python-ruff" },
  {
    "mfussenegger/nvim-dap-python",
    optional = true,
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      if require("user.utils").is_win() then
        path = path .. "\\venv\\Scripts\\python.exe"
      else
        path = path .. "/venv/bin/python"
      end
      require("dap-python").setup(path, opts)
    end,
  },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.split-and-window.edgy-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    optional = true,
    opts = function(_, opts)
      opts.lsp.progress = { enabled = false }
      opts.presets.lsp_doc_border = true
      return opts
    end,
  },
}
