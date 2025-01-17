local M = {}

M.running = {}

M.stop = function()
    if not next(M.running) == nil then
        vim.notify(
            "No running preview found",
            vim.log.levels.WARN
        )
        return
    end

    if M.running.stop == nil then
        vim.notify(
            "Failed to stop running preview",
            vim.log.levels.ERROR
        )
        return
    end

    if type(M.running.stop) == "string" then
        vim.cmd(M.running.stop)
        M.running = {}
    elseif type(M.running.stop) == "function" then
        M.running.stop()
        M.running = {}
    end
end

M.toggle = function()
    if next(M.running) == nil then
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
    for _, p in ipairs(pr or {}) do
        if type(p.trig) == "string" then
            if p.trig == ft or p.trig == fe then
                trig = true
            end
        elseif type(p.trig == "function") then
            if p.trig() then
                trig = true
            end
        end

        if trig then
            if type(p.start) == "string" then
                vim.cmd(p.start)
                M.running = p
                return
            elseif type(p.start) == "function" then
                p.start()
                M.running = p
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

