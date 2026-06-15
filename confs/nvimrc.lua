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
    vim.fn.isdirectory(vim.fn.stdpath("config") .. "/lua/plugins") == 1
    and { { import = "plugins" } }
    or {},
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        commit = '7d324792b7943e4aa16ad007212e6acc6f9fe335'
    },
    {'tpope/vim-surround', commit = '3d188ed2113431cf8dac77be61b842acb64433d9'},
    {'tpope/vim-repeat', commit = '65846025c15494983dafe5e3b46c8f88ab2e9635'},
    {'airblade/vim-gitgutter', commit = '21c977e8597c468c7dc76001389b0b430d46a4b0'},
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {'tpope/vim-fugitive', commit = '3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0'},
    {'tpope/vim-sensible', commit = '0ce2d843d6f588bb0c8c7eec6449171615dc56d9'},
    {'mbbill/undotree', commit = '6fa6b57cda8459e1e4b2ca34df702f55242f4e4d'},
    {'ellisonleao/gruvbox.nvim', commit = '154eb5ff5b96d0641307113fa385eaf0d36d9796'},
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
        'akinsho/toggleterm.nvim', 
        version = "*", 
        opts = {
            direction = 'float',
        },
        commit = '9a88eae817ef395952e08650b3283726786fb5fb'
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
        },
        commit = '882c996cf28183f4d63640de0b4c02ec886d01f2'
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = false,
        commit = '3610dc7dc91f06aa98b11dca5cc30dfa98626b7e'
    },
    {"MeanderingProgrammer/render-markdown.nvim", commit = '5adf0895310c1904e5abfaad40a2baad7fe44a07'},
    -- LSP START --
    {"L3MON4D3/LuaSnip", commit = '0abc8f390b278c3b4aabc4c004ac8a088b65cf24'},
    {"hrsh7th/nvim-cmp", commit = 'a1d504892f2bc56c2e79b65c6faded2fd21f3eca'},
    {"hrsh7th/cmp-nvim-lsp", commit = 'cbc7b02bb99fae35cb42f514762b89b5126651ef'},
    {"hrsh7th/cmp-buffer", commit = 'b74fab3656eea9de20a9b8116afa3cfc4ec09657'},
    {"hrsh7th/cmp-path", commit = 'c642487086dbd9a93160e1679a1327be111cbc25'},
    {"saadparwaiz1/cmp_luasnip", commit = '98d9cb5c2c38532bd9bdb481067b20fea8f32e90'},
    {"neovim/nvim-lspconfig", commit = 'a683e0ddf0cf64c6cd689e18ffb480ade3c162b7'},
    "okkuweb/snippets",
    -- LSP END --
    {
        "mrjones2014/smart-splits.nvim",
        lazy = false,
        opts = {
            default_amount = 1
        },
        commit = '501ea73e433246cbd53f0b14bbd205fa44831e4d'
    }
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
end
keyset({ "n", "t", "i" }, "<M-t>", toggle_term, { silent = true })
keyset("n", "<Leader>td", "<Esc>:TermExec cmd='todo && exit'<CR>")
keyset("n", "<Leader>tg", "<Esc>:TermExec cmd='togo && exit'<CR>")

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

-- Navigate between tmux and nvim splits splits
local splits = require('smart-splits')
vim.keymap.set({"n", "t"}, "<A-h>", splits.move_cursor_left)
vim.keymap.set({"n", "t"}, "<A-j>", splits.move_cursor_down)
vim.keymap.set({"n", "t"}, "<A-k>", splits.move_cursor_up)
vim.keymap.set({"n", "t"}, "<A-l>", splits.move_cursor_right)
vim.keymap.set('n', '<A-H>', function()
    splits.resize_left(6)
end)
vim.keymap.set('n', '<A-J>', function()
    splits.resize_down(3)
end)
vim.keymap.set('n', '<A-K>', function()
    splits.resize_up(3)
end)
vim.keymap.set('n', '<A-L>', function()
    splits.resize_right(6)
end)
vim.keymap.set("n", "<M-D>", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<M-X>", "<cmd>split<CR>")
vim.keymap.set("n", "<M-q>", "<cmd>q<CR>")

vim.opt.shada:append("/100")
vim.opt.shadafile = vim.fn.expand("~/.nvim/search.shada")

dofile(vim.fn.expand("~/.nvimlocal.lua"))
