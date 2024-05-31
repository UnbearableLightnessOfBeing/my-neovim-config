local ls = require("luasnip")

local types = require("luasnip.util.types")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.config.set_config {
  enable_autosnippets = true,
  history = true,
  updateevents = "TextChanged,TextChangedI",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = {{ "<-", "Error" }},
      },
    },
  },
}

-- remaps for luasnip
vim.keymap.set({ "i", "s" }, "<C-k>", function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("i" , "<C-l>", function ()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

-- make snippets
ls.snippets = {
  all = {
    ls.parser.parse_snippet({ trig = "expand" }, "-- this is what was expanded!!!"),
  },

  lua = {
    -- ls.parser.parse_snippet({ trig = "lf" }, "local $1 = function($2)\n  $0\nend")
  }
}
ls.parser.parse_snippet({ trig = "lf" }, "local $1 = function($2)\n  $0\nend")
ls.parser.parse_snippet({ trig = "lsp" }, "$1 is ${2|hard,easy,challenging|}")

ls.add_snippets('lua', {
  s(
    {
      trig = 'if',
      condition = function()
        local ignored_nodes = { 'string', 'comment' }

        local pos = vim.api.nvim_win_get_cursor(0)
        -- Use one column to the left of the cursor to avoid a "chunk" node
        -- type. Not sure what it is, but it seems to be at the end of lines in
        -- some cases.
        local row, col = pos[1] - 1, pos[2] - 1

        local node_type = vim.treesitter
          .get_node({
            pos = { row, col },
          })
          :type()

        return not vim.tbl_contains(ignored_nodes, node_type)
      end,
    },
    fmt(
      [[
if {} then
  {}
end
  ]],
      { i(1), i(2) }
    )
  ),
}, {
  type = 'autosnippets',
})


-- vue3 base snippet with setup and ts
ls.add_snippets('vue', {
  s(
  {
    trig = 'vbase-3-ts-setup',
  },
  fmt(
  [[
<template>
  <div></div>
</template>

<script setup lang="ts">

</script>

<style scoped lang="{}">

</style>
      ]],
      { i(1) }
    )
  ),
}, {
  type = 'autosnippets',
})

-- vue3 base snippet with setup and ts (script rirst)
ls.add_snippets('vue', {
  s(
  {
    trig = 'vue-3-ts-setup',
  },
  fmt(
  [[
<script setup lang="ts">

</script>

<template>
  <div></div>
</template>

<style scoped lang="{}">

</style>
      ]],
      { i(1) }
    )
  ),
}, {
  type = 'autosnippets',
})

-- go err snippet
-- ls.add_snippets('go', {
--   s(
--   {
--     trig = 'errsnip',
--   },
--   fmt(
--   [[
-- if err != nil {
--   return err
-- }
--   ]],
--       {}
--     )
--   ),
-- }, {
--   type = 'autosnippets',
-- })
