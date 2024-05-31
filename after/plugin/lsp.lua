local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'volar@1.8.5', 'cssls', 'html', 'htmx', 'gopls', 'tailwindcss' },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

-- volar version 2.x.x
-- local mason_registry = require('mason-registry')
-- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/typescript-plugin'
-- local lspconfig = require('lspconfig')
-- 
-- lspconfig.tsserver.setup {
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
--   init_options = {
--     plugings = {
--       {
--         name = '@vue/typescript-plugin',
--         location = vue_language_server_path,
--         languages = { 'vue' },
--       },
--     },
--   },
-- }

-- disable hybrid mode
-- require('lspconfig').volar.setup {
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
--   init_options = {
--     vue = {
--       hybridMode = false,
--     },
--   },
-- }

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

vim.diagnostic.config({
  virtual_text = {
    source = true
  },
  float = {
    source = true
  }
})

--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--  vim.lsp.diagnostic.on_publish_diagnostics, {
--    -- Enable underline, use default values
--    underline = true,
--    -- Enable virtual text, override spacing to 4
--    virtual_text = {
--      spacing = 4,
--    },
--    -- Use a function to dynamically turn signs off
--    -- and on, using buffer local variables
--    signs = function(namespace, bufnr)
--      return vim.b[bufnr].show_signs == true
--    end,
--    -- Disable a feature
--    update_in_insert = false,
--  }
--)
