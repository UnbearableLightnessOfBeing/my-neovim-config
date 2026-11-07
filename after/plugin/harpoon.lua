local harpoon = require('harpoon')
harpoon:setup()
harpoon:extend(require('harpoon.extensions').builtins.highlight_current_file())
harpoon:extend({
  UI_CREATE = function(context)
    vim.api.nvim_set_option_value('cursorline', true, { win = context.win_id })
    vim.api.nvim_set_option_value('cursorlineopt', 'line', { win = context.win_id })

    vim.keymap.set('n', '<C-v>', function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = context.bufnr, desc = 'Open Harpoon file in vertical split' })

    vim.keymap.set('n', '<C-x>', function()
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = context.bufnr, desc = 'Open Harpoon file in horizontal split' })
  end,
})

local active_list_name = nil

local function active_list()
  return harpoon:list(active_list_name)
end

vim.keymap.set('n', '<leader>a', function()
  active_list():add()
end, { desc = 'Add file to active Harpoon list' })

vim.keymap.set('n', '<C-h>', function()
  harpoon.ui:toggle_quick_menu(active_list(), {
    title = 'Harpoon: ' .. (active_list_name or 'default'),
  })
end, { desc = 'Open active Harpoon list' })

vim.keymap.set('n', '<leader>hl', function()
  vim.ui.input({
    prompt = 'Harpoon list (blank for default): ',
    default = active_list_name or '',
  }, function(name)
    if name == nil then
      return
    end

    name = vim.trim(name)
    active_list_name = name ~= '' and name or nil
    vim.notify('Harpoon list: ' .. (active_list_name or 'default'))
  end)
end, { desc = 'Switch Harpoon list' })
