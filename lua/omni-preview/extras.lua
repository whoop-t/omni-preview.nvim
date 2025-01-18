local M = {}

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
}

function M.setup()
    local function safe_setup(prev)
        local status, module = pcall(require, prev.name)
        if status and module and module.setup then
            module.setup(prev)
        end
    end

    for _, p in ipairs(M.previews) do
        safe_setup(p)
    end
end

return M
