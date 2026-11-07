return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    'nvim-telescope/telescope.nvim',
    -- branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        version = '^1.0.0',
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },

  'mbbill/undotree',

  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  'tpope/vim-fugitive',
  'tpope/vim-commentary',

  'neovim/nvim-lspconfig',
  'mason-org/mason.nvim',
  'mason-org/mason-lspconfig.nvim',

  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',

  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',

  'sbdchd/neoformat',

  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },

  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  },

  {
    'karb94/neoscroll.nvim',
    opts = {}
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
}
