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
            default_amount = 1,
            float_win_behavior = "mux",
        },
        commit = '501ea73e433246cbd53f0b14bbd205fa44831e4d'
    },
    {
        "nvim-mini/mini.map",
        commit = '86a150f1556d0293194d0327f7b4cb97c87920bb',
        lazy = false,
        dependencies = {
            {
                "lewis6991/gitsigns.nvim",
                commit = '31d6fb2d618bca1482b9f274751ead5f03461408',
                config = function()
                    local gitsigns = require("gitsigns")

                    gitsigns.setup({
                        on_attach = function(bufnr)
                            local function map_hunk(lhs, direction, description)
                                vim.keymap.set("n", lhs, function()
                                    gitsigns.nav_hunk(direction)
                                end, {
                                    buffer = bufnr,
                                    silent = true,
                                    desc = description,
                                })
                            end

                            map_hunk("<leader><", "prev", "Previous Git hunk")
                            map_hunk("<leader>,", "prev", "Previous Git hunk")
                            map_hunk("<leader>>", "next", "Next Git hunk")
                            map_hunk("<leader>.", "next", "Next Git hunk")
                            vim.keymap.set("n", "<leader>hu", gitsigns.reset_hunk, {
                                buffer = bufnr,
                                silent = true,
                                desc = "Reset Git hunk",
                            })
                            vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, {
                                buffer = bufnr,
                                silent = true,
                                desc = "Stage Git hunk",
                            })
                            vim.keymap.set("n", "<leader>hr", gitsigns.undo_stage_hunk, {
                                buffer = bufnr,
                                silent = true,
                                desc = "Unstage Git hunk",
                            })
                        end,
                    })
                end,
            },
        },
        config = function()
            local map = require("mini.map")
            local min_width = 110
            local map_width = 12
            local hide_on_overlap = true

            map.setup({
                integrations = {
                    map.gen_integration.builtin_search(),
                    map.gen_integration.gitsigns(),
                },
                window = {
                    side = "right",
                    width = map_width,
                    focusable = false,
                    show_integration_count = false,
                    winblend = 0,
                },
            })

            local function is_open()
                local win = map.current.win_data[vim.api.nvim_get_current_tabpage()]
                return win ~= nil and vim.api.nvim_win_is_valid(win)
            end

            local function visible_lines_overlap_map()
                local win = vim.api.nvim_get_current_win()
                if vim.api.nvim_win_get_config(win).relative ~= "" then
                    return false
                end

                local wininfo = vim.fn.getwininfo(win)[1]
                if wininfo == nil then
                    return false
                end

                local screen_col = vim.fn.win_screenpos(win)[2]
                local text_start_col = screen_col + wininfo.textoff
                local win_right_col = screen_col + vim.api.nvim_win_get_width(win) - 1
                local map_start_col = vim.o.columns - map_width + 1

                if win_right_col < map_start_col then
                    return false
                end

                local width_before_map = math.max(0, map_start_col - text_start_col)
                local leftcol = vim.fn.winsaveview().leftcol
                local first_line = vim.fn.line("w0")
                local last_line = vim.fn.line("w$")
                local lines = vim.api.nvim_buf_get_lines(0, first_line - 1, last_line, false)

                for index, line in ipairs(lines) do
                    local line_number = first_line + index - 1
                    if vim.fn.foldclosed(line_number) == -1 then
                        local line_width = vim.fn.strdisplaywidth(line)
                        local visible_width = math.max(0, line_width - leftcol)
                        if visible_width > width_before_map then
                            return true
                        end
                    end
                end

                return false
            end

            local function cursor_overlaps_map()
                local win = vim.api.nvim_get_current_win()
                if vim.api.nvim_win_get_config(win).relative ~= "" then
                    return false
                end

                local screen_col = vim.fn.win_screenpos(win)[2]
                local win_right_col = screen_col + vim.api.nvim_win_get_width(win) - 1
                local map_start_col = vim.o.columns - map_width + 1
                if win_right_col < map_start_col then
                    return false
                end

                local cursor = vim.api.nvim_win_get_cursor(win)
                local position = vim.fn.screenpos(win, cursor[1], cursor[2] + 1)
                local cursor_screen_col = position.curscol > 0 and position.curscol or position.col
                return cursor_screen_col >= map_start_col
            end

            local function sync_visibility()
                local should_open = vim.o.columns >= min_width
                    and not cursor_overlaps_map()
                    and (not hide_on_overlap or not visible_lines_overlap_map())

                if should_open and not is_open() then
                    map.open()
                elseif not should_open and is_open() then
                    map.close()
                end
            end

            local resize_group = vim.api.nvim_create_augroup("MiniMapResponsive", {
                clear = true,
            })
            vim.api.nvim_create_autocmd({
                "BufEnter",
                "CursorMoved",
                "CursorMovedI",
                "TextChanged",
                "TextChangedI",
                "VimResized",
                "WinEnter",
                "WinScrolled",
            }, {
                group = resize_group,
                callback = sync_visibility,
            })

            vim.keymap.set("n", "<leader>m", function()
                hide_on_overlap = not hide_on_overlap
                sync_visibility()
            end, {
                desc = "Toggle minimap overlap hiding",
            })

            sync_visibility()
        end,
    },
})

local actions = require("telescope.actions")
require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["<M-q>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-h>"] = "which_key",
            },
            n = {
                ["<M-q>"] = actions.close,
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
keyset("n", "<Leader>tt", "<cmd>ToggleTerm<CR>", { silent = true })

local function command_float(command)
  vim.system(command, { text = true }, vim.schedule_wrap(function(result)
    local output = (result.stdout or "") .. (result.stderr or "")
    local lines = output == "" and { "(no output)" }
      or vim.split(vim.trim(output), "\n", { plain = true })
    local buffer, window = vim.lsp.util.open_floating_preview(lines, "text", {
      border = "rounded",
      title = table.concat(command, " "),
    })
    vim.api.nvim_set_current_win(window)
    local close = function()
      if vim.api.nvim_win_is_valid(window) then vim.api.nvim_win_close(window, true) end
    end
    keyset("n", "q", close, { buffer = buffer, silent = true })
    keyset("n", "<Esc>", close, { buffer = buffer, silent = true })
  end))
end

local runners = {
  javascript = { "node" },
  perl = { "perl" },
  python = { "python3" },
  sh = { "bash" },
  expect = { "expect" },
  go = { "go", "run" },
}

local function run_current_file()
  if vim.bo.filetype == "rust" then
    vim.cmd.write()
    command_float({ "sh", "-c", "cargo-root && cargo run" })
    return
  end
  local command = vim.deepcopy(runners[vim.bo.filetype])
  if not command then
    vim.notify("No runner for " .. vim.bo.filetype, vim.log.levels.ERROR)
    return
  end
  vim.cmd.write()
  table.insert(command, vim.api.nvim_buf_get_name(0))
  command_float(command)
end

local function file_float(file)
  Snacks.win({
    file = file,
    width = 0.8,
    height = 0.8,
    border = "rounded",
    enter = true,
    bo = { readonly = false, modifiable = true },
    keys = { q = "hide", ["<Esc>"] = "hide" },
  })
end

keyset("n", "<Leader>td", function()
  file_float(vim.fn.expand("~/.todo.md"))
end)
keyset("n", "<Leader>tg", function()
  local root = vim.trim(vim.fn.system({ "git", "rev-parse", "--show-toplevel" }))
  if vim.v.shell_error ~= 0 then
    vim.notify("Not inside a Git repository", vim.log.levels.ERROR)
    return
  end
  file_float(root .. "/todo.md")
end)
keyset("n", "<Leader>r", run_current_file, { desc = "Run current file" })
keyset("n", "<Leader>R", function()
  vim.cmd.write()
  command_float({ "sh", "-c", "go build -o app && ./app" })
end, { desc = "Build and run Go" })

vim.opt.undofile = true
vim.o.undodir = vim.fn.expand("~/.nvim/tempfiles")

require("gruvbox").setup({
    bold = false,
})
vim.cmd("colorscheme gruvbox")
vim.api.nvim_set_hl(0, "MiniMapNormal", { bg = "NONE", fg = "#504945" })
vim.api.nvim_set_hl(0, "MiniMapSymbolLine", { fg = "#928374" })
vim.api.nvim_set_hl(0, "MiniMapSymbolView", { fg = "#504945" })

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
