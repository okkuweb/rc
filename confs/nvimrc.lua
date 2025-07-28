vim.cmd("set runtimepath^=~/.vim runtimepath+=~/.vim/after")
vim.cmd("let &packpath=&runtimepath")
vim.cmd("source ~/.vimrc")

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
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'airblade/vim-gitgutter',
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    'tpope/vim-fugitive',
    'tpope/vim-sensible',
    'mbbill/undotree',
    'ellisonleao/gruvbox.nvim',
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        branch = "dev",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "telescope.nvim",
        },
        opts = {
            lang = "golang",
            storage = {
                home = vim.fn.expand("~/git/leetcode"),
            },
        },
        keys = {
            { "<leader>lq", mode = { "n" }, "<cmd>Leet tabs<cr>" },
            { "<leader>lm", mode = { "n" }, "<cmd>Leet menu<cr>" },
            { "<leader>lc", mode = { "n" }, "<cmd>Leet console<cr>" },
            { "<leader>lh", mode = { "n" }, "<cmd>Leet info<cr>" },
            { "<leader>ll", mode = { "n" }, "<cmd>Leet lang<cr>" },
            { "<leader>ld", mode = { "n" }, "<cmd>Leet desc<cr>" },
            { "<leader>lr", mode = { "n" }, "<cmd>Leet run<cr>" },
            { "<leader>ls", mode = { "n" }, "<cmd>Leet submit<cr>" },
            { "<leader>ly", mode = { "n" }, "<cmd>Leet yank<cr>" },
        },
        cmd = "Leet",
    },
    {
        'akinsho/toggleterm.nvim', version = "*", opts = {
            direction = 'float',
        }
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            statuscolumn = { enabled = true },
        },
        keys = {
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
        }
    },
    {
        'neoclide/coc.nvim',
        branch = 'release',
        -- using BufReadPost instead of BufReadPre in this case might be better
        event = { 'BufReadPre', 'BufNewFile'}
    },
})

local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

vim.cmd("colorscheme gruvbox")
vim.cmd("tnoremap <Esc> <C-\\><C-n>")

-- CoC Settings
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gt", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
keyset("n", "g<", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "g>", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "ga", ":<C-u>CocList diagnostics<cr>")

-- Other keybinds
keyset("t", "<Esc>", "<C-\\><C-n>", {silent = true})
keyset("n", "<leader>t", ":ToggleTerm<CR>", {silent = true})

vim.opt.undofile = true
vim.o.undodir = vim.fn.expand("~/.nvim/tempfiles")

dofile(vim.fn.expand("~/.nvimlocal"))
