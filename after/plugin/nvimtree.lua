-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.del('n', '<C-t>', { buffer = bufnr })
  vim.keymap.set('n', '<C-c>', ':NvimTreeCollapse<CR>', opts('Collapse'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  on_attach = my_on_attach,

  hijack_netrw = false,
  disable_netrw = false,
  hijack_directories = {
    enable = false, -- Prevents auto-open on directory launch [page:1]
  },
}

vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>')
