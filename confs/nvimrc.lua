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
})

vim.cmd("colorscheme gruvbox")

dofile(vim.fn.expand("~/.nvimlocal"))
