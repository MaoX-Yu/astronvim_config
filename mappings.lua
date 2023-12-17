-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

    -- my config
    ["Q"] = { "q", desc = "Create macros" },
    ["q"] = { "@", desc = "Use macros" },
    ["<C-a>"] = { "ggvG$", desc = "Select all" },
    ["gh"] = { "^", desc = "Move to the start of line" },
    ["gl"] = { "$", desc = "Move to the end of line" },
    -- rename
    ["<leader>r"] = { name = "󰑕 Refactor" },
    ["<leader>rn"] = {
      function() vim.lsp.buf.rename() end,
      desc = "Rename current symbol",
    },
    ["<leader><leader>"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
  },
  v = {
    -- my config
    ["gh"] = { "^", desc = "Move to the start of line" },
    ["gl"] = { "$", desc = "Move to the end of line" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,

    --my config
    ["<esc><esc>"] = { "<c-\\><c-n>", desc = "Enter normal mode" },
  },
}
