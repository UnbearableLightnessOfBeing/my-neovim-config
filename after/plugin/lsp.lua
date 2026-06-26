-- Capabilities for all servers (nvim-cmp integration)
vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Buffer-local LSP keymaps on attach (replaces lsp_zero.on_attach)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  end,
})

-- Per-server overrides (merged over nvim-lspconfig's lsp/<name>.lua defaults)
vim.lsp.config('gopls', {
  settings = { gopls = { buildFlags = { '-tags=integration,wireinject' } } },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
    },
  },
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'rust_analyzer', 'lua_ls', 'html', 'gopls', 'helm_ls' },
  automatic_enable = true, -- replaces handlers/default_setup; calls vim.lsp.enable
})

-- nvim-cmp (lsp-zero no longer wires the snippet engine / capabilities)
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

vim.diagnostic.config({
  virtual_text = { source = true },
  float = { source = true },
})

-- brief: custom filetype + LSP (already modern; keep as-is)
vim.lsp.config("briefls", {
  cmd = { "briefls" },
  filetypes = { "brief" },
  root_markers = { ".git" },
  single_file_support = true,
  flags = { debounce_text_changes = 150 },
  capabilities = {
    workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
  },
})
vim.lsp.enable("briefls")

vim.filetype.add { extension = { brief = "brief" } }
