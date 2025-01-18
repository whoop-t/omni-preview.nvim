local M = {}
M.running_previews = {}

M.stop = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local rp = M.running_previews[current_buf]
    if rp == nil or not rp.running then
        vim.notify(
            "No running preview found",
            vim.log.levels.WARN
        )
        return
    end

    local p = rp.preview
    if p.stop == nil then
        vim.notify(
            "Failed to stop running preview, no command provided",
            vim.log.levels.ERROR
        )
        return
    end

    if type(p.stop) == "string" then
        M.running_previews[current_buf].running = false
        vim.cmd(p.stop)
    elseif type(p.stop) == "function" then
        M.running_previews[current_buf].running = false
        p.stop()
    end
end

M.toggle = function()
    local current_buf = vim.api.nvim_get_current_buf();
    local p = M.running_previews[current_buf]
    if p == nil or not p.running then
        M.start()
    else
        M.stop()
    end
end

function M.start()
    local ft = vim.bo.filetype
    local fe = vim.fn.expand("%:e")
    local pr = require("omni-preview").previews
    local trig = false
    local current_buf = vim.api.nvim_get_current_buf()
    for _, p in ipairs(pr or {}) do
        if type(p.trig) == "string" then
            if p.trig == ft or p.trig == fe then
                trig = true
            end
        elseif type(p.trig) == "function" then
            if p.trig() then
                trig = true
            end
        end

        if trig then
            if type(p.start) == "string" then
                vim.cmd(p.start)
                M.running_previews[current_buf] = { running = true, preview = p }
                return
            elseif type(p.start) == "function" then
                p.start()
                M.running_previews[current_buf] = { running = true, preview = p }
                return
            else
                vim.notify(
                    "Invalid preview command for filetype: " .. ft,
                    vim.log.levels.ERROR
                )
                return
            end
        end
    end

    vim.notify(
        "No preview available for filetype: " .. ft,
        vim.log.levels.WARN
    )
end

return M
