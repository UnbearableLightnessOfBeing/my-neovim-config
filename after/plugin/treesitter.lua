require('nvim-treesitter').setup()

local ensure = {
  "c", "lua", "vim", "javascript", "typescript", "go", "rust", "python",
  "vue", "css", "scss", "html", "bash", "markdown", "vimdoc", "yaml", "brief",
}

-- Custom 'brief' parser (Avito-internal). Registered before install runs.
-- VERIFY: main-branch install_info schema documents url/revision/location/generate;
-- the old `files = {...}` key may need to become `location`/`generate`. Confirm against
-- the brief repo layout and the main README if the brief parser fails to build.
require('nvim-treesitter.parsers').brief = {
  install_info = {
    url = "ssh://git@stash.msk.avito.ru:7999/~ddfomin/tree-sitter-brief.git",
    files = { "src/parser.c" },
  },
}

require('nvim-treesitter').install(ensure)
vim.treesitter.language.register("brief", "brief")

-- Enable TS highlight (and indent) wherever a parser exists. pcall guards
-- filetypes with no parser, since vim.treesitter.start() errors otherwise.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    if pcall(vim.treesitter.start) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
