require('luasnip').config.set_config {
  enable_autosnippets = true,
}

local ls = require 'luasnip'
local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node

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
