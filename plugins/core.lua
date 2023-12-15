return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " _______",
        "|       \\",
        "| ███████\\ ______   ______  _______  __    __  ______",
        "| ██__/ ██/      \\ /      \\|       \\|  \\  |  \\|      \\",
        "| ██    ██  ██████\\  ██████\\ ███████\\ ██  | ██ \\██████\\",
        "| ███████\\ ██   \\██ ██  | ██ ██  | ██ ██  | ██/      ██",
        "| ██__/ ██ ██     | ██__/ ██ ██  | ██ ██__/ ██  ███████",
        "| ██    ██ ██      \\██    ██ ██  | ██\\██    ██\\██    ██",
        " \\███████ \\██       \\██████ \\██   \\██_\\███████ \\███████",
        "                                    |  \\__| ██",
        "                                     \\██    ██",
        "                                      \\██████",
      }
      local button, get_icon = require("astronvim.utils").alpha_button, require("astronvim.utils").get_icon
      opts.section.buttons.val = {
        button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
        button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
        button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
        button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
        button("LDR f '", get_icon("Bookmarks", 2, true) .. "Bookmarks  "),
        button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  "),
      }

      opts.config.layout = {
        { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
        opts.section.header,
        { type = "padding", val = 4 },
        opts.section.buttons,
        { type = "padding", val = 3 },
        opts.section.footer,
      }
      return opts
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {
      mapping = { "jj", "fd" },
      clear_empty_lines = true,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require "luasnip"
      local cmp = require "cmp"
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-o>"] = cmp.mapping(function(fallback)
          if has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
      return opts
    end,
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
  },
  {
    "rafamadriz/friendly-snippets",
    config = function() require("luasnip.loaders.from_vscode").lazy_load { paths = { "./lua/user/snippets" } } end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts = vim.tbl_extend("force", opts, {
        window = {
          border = "single",
          position = "top",
        },
      })
      return opts
    end,
  },
  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  --
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },
}
