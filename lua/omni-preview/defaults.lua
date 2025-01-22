-- local npm = require "omni-preview.npm"
local M = {}

M.system_open = function()
    local filename = vim.fn.expand("%:p")
    local success = os.execute("open " .. filename)
    if not success then
        print("Could not use system command \"open\" to open " .. filename)
    end
end

M.previews = {
    { name = "typst-preview", trig = "typst", start = "TypstPreview", stop = "TypstPreviewStop" },
    { name = "vimtex",        trig = "tex",   start = "LatexStart" },
    {
        name = "csvview",
        trig = "csv",
        start = "CsvViewEnable",
        stop = "CsvViewDisable",
    },
    {
        name = "peek",
        trig = "markdown",
        start = function() require "peek".open() end,
        stop = function() require "peek".close() end,
    },
    { trig = "pdf",  start = M.system_open, name = "builtin" },
    { trig = "svg",  start = M.system_open, name = "builtin" },
    { trig = "png",  start = M.system_open, name = "billtin" },
    { trig = "jpeg", start = M.system_open, name = "builtin" },
    { trig = "html", start = M.system_open, name = "builtin" },
}

return M
