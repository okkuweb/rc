vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()

        local function get_current_line()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        return row, vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    end

    local function analyze_line()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    if not line then return nil end

    local indent, content = line:match("^(%s*)(.*)$")

    local rest = content:match("^%- %[x%] (.*)$")
    if rest ~= nil then
        if rest:match("^%s*$") then
            return { action = "delete", indent = indent, row = row }
        end
        return { action = "newline", bullet = "- [ ] " }
    end

    rest = content:match("^%- %[ %] (.*)$")
    if rest ~= nil then
        if rest:match("^%s*$") then
            return { action = "delete", indent = indent, row = row }
        end
        return { action = "newline", bullet = "- [ ] " }
    end

    rest = content:match("^%- (.*)$")
    if rest ~= nil then
        if rest:match("^%s*$") then
            return { action = "delete", indent = indent, row = row }
        end
        return { action = "newline", bullet = "- " }
    end

    return nil
end

local function is_list_line(line)
if not line then return false end
local content = line:match("^%s*(.*)$")
return content:match("^%- ")
    end

    -- Insert mode <CR>
    vim.keymap.set("i", "<CR>", function()
        local info = analyze_line()
        if not info then return "\n" end

        if info.action == "delete" then
            vim.schedule(function()
                vim.api.nvim_buf_set_lines(0, info.row - 1, info.row, false, { info.indent })
                vim.api.nvim_win_set_cursor(0, { info.row, #info.indent })
            end)
            return ""
        end

        if info.action == "newline" then
            return "\n" .. info.bullet
        end

        return "\n"
    end, { buffer = true, expr = true, silent = true })

    -- Insert mode <Tab> (indent, preserve cursor column)
    vim.keymap.set("i", "<Tab>", function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local _, line = get_current_line()

        if not is_list_line(line) then
            return "\t"
        end

        local before_col = col
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<C-o>>>", true, false, true),
            "n",
            false
        )

        vim.schedule(function()
            vim.api.nvim_win_set_cursor(0, { row, before_col + vim.o.shiftwidth })
        end)

        return ""
    end, { buffer = true, expr = true, silent = true })

    -- Insert mode <S-Tab> (dedent, preserve cursor column)
    vim.keymap.set("i", "<S-Tab>", function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local _, line = get_current_line()

        if not is_list_line(line) then
            return "<S-Tab>"
        end

        local before_col = col
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<C-o><<", true, false, true),
            "n",
            false
        )

        vim.schedule(function()
            local new_col = before_col - vim.o.shiftwidth
            if new_col < 0 then new_col = 0 end
            vim.api.nvim_win_set_cursor(0, { row, new_col })
        end)

        return ""
    end, { buffer = true, expr = true, silent = true })

    -- Normal mode o
    vim.keymap.set("n", "o", function()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
        local trimmed = line:match("^%s*(.*)$")

        -- Only override if the line starts with a markdown list
        if trimmed:match("^%- ") then
            local info = analyze_line()
            if info and info.action == "newline" then
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("o" .. info.bullet, true, false, true),
                    "n",
                    false
                )
                return
            end
        end

        -- Normal behavior for non-list lines
        return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("o", true, false, true), "n", false)
    end, { buffer = true, silent = true, noremap = true })

    -- Normal mode O
    vim.keymap.set("n", "O", function()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
        local trimmed = line:match("^%s*(.*)$")

        if trimmed:match("^%- ") then
            local info = analyze_line()
            if info and info.action == "newline" then
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("O" .. info.bullet, true, false, true),
                    "n",
                    false
                )
                return
            end
        end

        -- Normal behavior for non-list lines
        return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("O", true, false, true), "n", false)
    end, { buffer = true, silent = true, noremap = true })

    -- Toggle checkbox <leader>c
    vim.keymap.set("n", "<leader>c", function()
        local row, line = get_current_line()
        if not line then return end

        local indent, content = line:match("^(%s*)(.*)$")

        if content:match("^%- %[ %] ") then
            content = content:gsub("^%- %[ %] ", "- [x] ", 1)
        elseif content:match("^%- %[x%] ") then
            content = content:gsub("^%- %[x%] ", "- [ ] ", 1)
        else
            return
        end

        vim.api.nvim_buf_set_lines(0, row - 1, row, false, { indent .. content })
    end, { buffer = true, silent = true, noremap = true })

end,
})

