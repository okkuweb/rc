set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
lua << EOF
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Setup lazy.nvim
require("lazy").setup({
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'airblade/vim-gitgutter',
    'jiangmiao/auto-pairs',
    'tpope/vim-fugitive',
    'tpope/vim-sensible',
    'roxma/vim-tmux-clipboard',
    'tmux-plugins/vim-tmux-focus-events',
    'mbbill/undotree',
    'ellisonleao/gruvbox.nvim',
    'aserowy/tmux.nvim',
    "neovim/nvim-lspconfig",
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
        branch = "dev",
        dependencies = {
            -- include a picker of your choice, see picker section for more details
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            -- lsp_keymaps = false,
            -- other options
        },
        config = function(lp, opts)
        require("go").setup(opts)
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
            require('go.format').goimports()
            end,
            group = format_sync_grp,
        })
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
})

vim.cmd("colorscheme gruvbox")
require'lspconfig'.gopls.setup{}

dofile(vim.fn.expand("~/.nvimlocal"))
EOF

