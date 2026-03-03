-- LuaSnip
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp
local cmp = require("cmp")

cmp.setup({
    preselect = cmp.PreselectMode.None,
    completion = { completeopt = "menu,menuone,noinsert" },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
        end, {"i","s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
        end, {"i","s"}),
        ["<C-x>"] = function(fallback)
            if cmp.visible() then cmp.close() else cmp.complete() end
        end,
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

-- LSP
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.diagnostic.config({ signs = { priority = 1000 } })

-- Go
vim.lsp.config.gopls = {
    { 
        cmd = { "gopls", "-remote=auto" },
        capabilities = capabilities 
    }
}
vim.lsp.enable('gopls')

vim.lsp.config.perlnavigator = {
    {
        cmd = { "perlnavigator", "--stdio" },
        filetypes = { "perl" },
        includePaths = { "/opt/*/lib" },
        capabilities = capabilities,
    }
}
vim.lsp.enable('perlnavigator')

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local buf = args.buf
        local function map(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true })
        end

        map("gd", vim.lsp.buf.definition)
        map("gt", vim.lsp.buf.type_definition)
        map("gI", vim.lsp.buf.implementation)
        map("gr", vim.lsp.buf.references)
        map("gs", vim.lsp.buf.hover)
        map("gn", vim.lsp.buf.rename)
        map("gi", function()
            vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
        end)

        local function jump_error(count)
            vim.diagnostic.jump({ count = count, severity = vim.diagnostic.severity.ERROR })
        end
        map("g>", function() jump_error(1) end)
        map("g.", function() jump_error(1) end)
        map("g<", function() jump_error(-1) end)
        map("g,", function() jump_error(-1) end)
        map("ge", function()
            vim.diagnostic.open_float(nil, { border = "rounded", source = "if_many" })
        end)

        local lsp_active = true
        map("gx", function()
            lsp_active = not lsp_active
            if lsp_active then vim.diagnostic.enable() else vim.diagnostic.disable() end
            print("LSP functionality " .. (lsp_active and "enabled" or "disabled"))
        end)
    end,
})
