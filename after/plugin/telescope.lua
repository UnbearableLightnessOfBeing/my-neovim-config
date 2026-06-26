local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})

-- builtin.find_files({ layout_strategy = 'vertical', layout_config = { width = 0.9 } })

local telescope = require('telescope')

telescope.setup(
  {
    defaults = {
      layout_config = {
        horizontal = {
          width = 0.99,
          height = 0.99,
          preview_width = 0.6,
        }
      },
      preview = {
        filesize_limit = 0.1,
        timeout = 300,
        highlight_limit = 0.5,
      },
    },

    pickers = {
      find_files = {
        filesize_limit = 0.1,
        hide_on_startup = true,
      },
    },
  }
)

telescope.load_extension('live_grep_args')

vim.keymap.set('n', '<leader>pa', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

--vim.keymap.set('n', '<leader>ps', function()
--	builtin.grep_string({ search = vim.fn.input("Grep > ") })
--end)
