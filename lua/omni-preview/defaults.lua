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
    { trig = "markdown", start = function() require "peek".open() end, stop = function() require "peek".close() end },
    { trig = "typst",    start = "TypstPreview" },
    { trig = "pdf",      start = M.system_open },
    { trig = "svg",      start = M.system_open },
    { trig = "png",      start = M.system_open },
    { trig = "jpeg",     start = M.system_open },
    { trig = "html",     start = M.system_open },
    { trig = "csv",      start = "CsvViewEnable",                      stop = "CsvViewDisable" },
    npm,
}

return M
