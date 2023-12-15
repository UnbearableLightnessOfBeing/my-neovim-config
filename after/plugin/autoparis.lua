local Rule = require('nvim-autopairs.rule')
local ts_conds = require('nvim-autopairs.ts-conds')

require('nvim-autopairs').add_rules {
  Rule('{{', '  }', 'vue')
  :set_end_pair_length(2)
  :with_pair(ts_conds.is_ts_node 'text'),
}
