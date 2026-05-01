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
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
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
    --{
    --    "kawre/leetcode.nvim",
    --    build = ":TSUpdate html",
    --    branch = "dev",
    --    dependencies = {
    --        "nvim-lua/plenary.nvim",
    --        "MunifTanjim/nui.nvim",
    --    },
    --    opts = {
    --        lang = "golang",
    --        storage = {
    --            home = (function()
    --                local expand, stat = vim.fn.expand, vim.loop.fs_stat
    --                return (stat(expand("~/git")) and expand("~/git/leetcode"))
    --                or (stat(expand("~/Git")) and expand("~/Git/leetcode"))
    --                or expand("~/.leetcode")
    --            end)(),
    --        },
    --    },
    --    keys = {
    --        { "<leader>lq", mode = { "n" }, "<cmd>Leet tabs<cr>" },
    --        { "<leader>lm", mode = { "n" }, "<cmd>Leet menu<cr>" },
    --        { "<leader>lc", mode = { "n" }, "<cmd>Leet console<cr>" },
    --        { "<leader>lh", mode = { "n" }, "<cmd>Leet info<cr>" },
    --        { "<leader>ll", mode = { "n" }, "<cmd>Leet lang<cr>" },
    --        { "<leader>ld", mode = { "n" }, "<cmd>Leet desc<cr>" },
    --        { "<leader>lr", mode = { "n" }, "<cmd>Leet run<cr>" },
    --        { "<leader>ls", mode = { "n" }, "<cmd>Leet submit<cr>" },
    --        { "<leader>ly", mode = { "n" }, "<cmd>Leet yank<cr>" },
    --    },
    --    cmd = "Leet",
    --},
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
        },
        keys = {
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
        }
    },
    "simeji/winresizer",
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = false,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    "MeanderingProgrammer/render-markdown.nvim",
    -- LSP START --
    "L3MON4D3/LuaSnip",
    "okkuweb/snippets",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "neovim/nvim-lspconfig",
    -- LSP END --
})

local actions = require("telescope.actions")
require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-h>"] = "which_key",
            },
            n = {
                ["<C-c>"] = actions.close,
                ["<Leader>q"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-h>"] = "which_key",
            },
        },
    },
    extensions = {
        file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    ["<bs>"] = false,
                },
            },
            initial_mode = "normal",
        },
    },
    pickers = {
        buffers = {
            initial_mode = "normal",
        }
    }
}

require("telescope").load_extension "file_browser"
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<space>ft", ":Telescope file_browser<CR>")

local keyset = vim.keymap.set

-- Other keybinds
keyset("t", "<Esc>", "<C-\\><C-n>", {silent = true})
local keyset = vim.keymap.set
local function toggle_term()
  if vim.fn.mode() == "t" then
    vim.cmd("stopinsert")
  elseif vim.fn.mode() == "i" then
    vim.cmd("stopinsert")
  end

  vim.cmd("ToggleTerm")
  vim.cmd("startinsert")
end
keyset({ "n", "i", "t" }, "<C-t>", toggle_term, { silent = true })
keyset("n", "<Leader>td", ":TermExec cmd='todo && exit'<CR>")
keyset("n", "<Leader>tg", ":TermExec cmd='togo && exit'<CR>")

vim.opt.undofile = true
vim.o.undodir = vim.fn.expand("~/.nvim/tempfiles")

require("gruvbox").setup({
    bold = false,
})
vim.cmd("colorscheme gruvbox")
vim.cmd("tnoremap <Esc> <C-\\><C-n>")

-- Open file where the cursor was in file before closing
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = lastplace,
    pattern = { "*" },
    desc = "remember last cursor place",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

dofile(vim.fn.expand("~/.nvimlocal.lua"))
