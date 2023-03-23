-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- stylua: ignore start
require('lazy').setup({
    'nvim-lua/popup.nvim',
    'stevearc/dressing.nvim',
    'windwp/nvim-ts-autotag',
    'norcalli/nvim-colorizer.lua',
    'windwp/nvim-autopairs',
    'akinsho/toggleterm.nvim',      
    'lukas-reineke/indent-blankline.nvim',
    'tpope/vim-fugitive',
    'karb94/neoscroll.nvim',
    'tpope/vim-rhubarb',
    'onsails/lspkind.nvim',
    'goolord/alpha-nvim',
    { 
      'lewis6991/gitsigns.nvim',
      dependencies = { 
        'nvim-lua/plenary.nvim' 
      }, 
    },
    { 'numToStr/Comment.nvim', opts = {} },
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      config = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
      end,
    },
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp' 
      }, 
    },
    'akinsho/bufferline.nvim',
    { 
      'L3MON4D3/LuaSnip',
      dependencies = { 
        'saadparwaiz1/cmp_luasnip' 
      }, 
    },
    'nvim-lualine/lualine.nvim',
    'kyazdani42/nvim-tree.lua',
    'lewis6991/impatient.nvim',
    'tpope/vim-sleuth',
    'nvim-treesitter/playground',
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim'
      },
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      'Exafunction/codeium.vim',
      dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      config = function()
        vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
        vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
        vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
        vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
      end
    },
}, {})

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Setting options
vim.o.cursorline = true                      -- Set highlight cursor
vim.o.hlsearch = false                       -- Set highlight on search
vim.wo.number = true                         -- Make line numbers default
vim.o.mouse = "a"                            -- Enable mouse mode
vim.o.breakindent = true                     -- Enable break indent
vim.o.undofile = true                        -- Save undo history
vim.o.ignorecase = true                      -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
vim.o.updatetime = 250                       -- Decrease update time
vim.wo.signcolumn = 'yes'
vim.o.autoindent = true
vim.o.clipboard = "unnamedplus"              -- use system clipboard by default
vim.o.completeopt = 'menuone,noselect'       -- Set completeopt to have a better completion experience
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.o.termguicolors = true                   -- Set colorscheme
vim.cmd [[colorscheme dunkelsee]]

-- Keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Move text up and down (visual mode)
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move text up and down (insert mode)
vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })

-- Default Text Editors
vim.keymap.set('n', '<c-s>', ':w<CR>', {})
vim.keymap.set('n', 'Q', '<c-v>', {})
vim.keymap.set('n', 'fq', ':q!<CR>', {})
vim.keymap.set('n', 'qq', ':q<CR>', {})
vim.keymap.set('i', '<C-b>', '<ESC>^i', {})
vim.keymap.set('i', '<C-e>', '<End>', {})

-- UI
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', {})
vim.keymap.set('n', '<leader>h', ':split<CR>', {})
vim.keymap.set('n', '<leader>w', ':set wrap<CR>', {})

-- Indent
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Plugins
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-t>', ':ToggleTerm<CR>', {})
vim.keymap.set('n', '<A-i>', ':ToggleTerm direction=float<CR>', {})

-- Telescope
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = 'Search by [G]it [C]omment' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Search by [G]it [S]tatus' })

-- Once the plugins have been loaded, Lua-based plugins need to be required and started up
-- For plugins with their own configuration file, that file is loaded and is responsible for
-- starting them. Otherwise, the plugin itself is required and its `setup` method is called.
require('Comment').setup()
require('colorizer').setup()
require('nvim-autopairs').setup()
require('gitsigns').setup()
require('nvim-tree').setup()
require('neoscroll').setup()
require('lspconfig')
require('impatient')

-- Mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = " ",
            package_pending = " ",
            package_uninstalled = "ﮊ "
        }
    }
})
require("mason-lspconfig").setup()

-- Telescope
require('telescope').setup {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
-- Github
require('gitsigns').setup {
  signs = {
    add = { hl = "DiffAdd", text = '🞧', numhl = "GitSignsAddNr" },
    change = { hl = "DiffChange", text = '⏺', numhl = "GitSignsChangeNr" },
    delete = { hl = "DiffDelete", text = '🭸', numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "DiffDelete", text = '🭶', numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "DiffChangeDelete", text = '~', numhl = "GitSignsChangeNr" },
    untracked = { hl = "GitSignsAdd", text = '', numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
  },
}
