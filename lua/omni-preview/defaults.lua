local npm = require "omni-preview.npm"
local M = {}

M.system_open = function()
    local filename = vim.fn.expand("%:p")
    local success = os.execute("open " .. filename)
    if not success then
        print("Could not use system command \"open\" to open " .. filename)
    end
end

M.previews = {
    { trig = "markdown", cmd = function() require "peek".open() end },
    { trig = "typst",    cmd = "TypstPreview" },
    { trig = "pdf",      cmd = M.system_open },
    { trig = "svg",      cmd = M.system_open },
    { trig = "png",      cmd = M.system_open },
    { trig = "jpeg",     cmd = M.system_open },
    { trig = "html",     cmd = M.system_open },
    { trig = "csv",      cmd = "CsvViewEnable" },
    npm,
}

return M
