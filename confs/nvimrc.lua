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
                home = (function()
                    local expand, stat = vim.fn.expand, vim.loop.fs_stat
                    return (stat(expand("~/git")) and expand("~/git/leetcode"))
                    or (stat(expand("~/Git")) and expand("~/Git/leetcode"))
                    or expand("~/.leetcode")
                end)(),
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
    "simeji/winresizer",
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = false,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
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
        },
    },
}
require("telescope").load_extension "file_browser"
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fB', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")

local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

-- Golang configs
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
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
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gt", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("n", "gs", '<CMD>lua _G.show_docs()<CR>', {silent = true})
keyset("n", "gn", "<Plug>(coc-rename)", {silent = true})
keyset("n", "g<", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "g>", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "g,", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "g.", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "ga", ":<C-u>CocList diagnostics<cr>")
vim.g.coc_user_config = {
    suggest = {
        enablePreselect = false,
        noselect = true,
        selection = "first",
    }
}

cocenabled = true
vim.keymap.set('n', 'gx', function()
    if cocenabled then
        vim.cmd('CocDisable')
        vim.cmd('echo "CoC Disabled"')
        cocenabled = false
    else
        vim.cmd('CocEnable')
        vim.cmd('echo "CoC Enabled"')
        cocenabled = true
    end
end, { noremap = true, silent = true })

function GoImports()
    -- Save the current window view
    local view = vim.fn.winsaveview()

    -- Run gofmt on the whole buffer silently
    vim.cmd("silent %!goimports")

    -- If there was a shell error (non-zero exit code)
    if vim.v.shell_error > 0 then
        -- Replace "<standard input>" with the filename in the error list
        local lines = vim.fn.getline(1, "$")
        local filename = vim.fn.expand("%")
        local errors = table.concat(vim.tbl_map(function(val)
            return string.gsub(val, "<standard input>", filename)
        end, lines), "\n")

        vim.notify(errors, "error")
        vim.cmd("silent undo")  -- Undo the formatting
    else 
        vim.cmd("write")
    end

    -- Restore the original window view
    vim.fn.winrestview(view)
end

vim.api.nvim_create_user_command("GoImports", GoImports, {})

-- Other keybinds
keyset("t", "<Esc>", "<C-\\><C-n>", {silent = true})
keyset("n", "<leader>t", ":ToggleTerm<CR>", {silent = true})

vim.opt.undofile = true
vim.o.undodir = vim.fn.expand("~/.nvim/tempfiles")

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
