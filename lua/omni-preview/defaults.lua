-- local npm = require "omni-preview.npm"
local M = {}

M.system_open = function()
    local filename = vim.fn.expand("%:p")
    local success = os.execute("open " .. vim.fn.shellescape(filename))
    if not success then
        print("Could not use system command \"open\" to open " .. filename)
    end
end

M.build_config = function()
    local trim = {}
    for index, preview in ipairs(M.previews) do
        local ok, module = pcall(require, preview.name)
        if preview.name == "builtin" or (ok and module ~= nil) then
            table.insert(trim, preview)
        end
    end

    return trim
end

-- TODO consolidate the default previews using some kind of loop
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
        name = "data-viewer",
        trig = "csv",
        start = "DataViewer",
        stop = "DataViewerClose",
    },
    {
        name = "markdown-preview",
        trig = "markdown",
        start = "MarkdownPreview",
        stop = "MarkdownPreviewStop",
    },
    {
        name = "github-preview",
        trig = "markdown",
        start = function() require "github-preview".fns.start() end,
        stop = function() require "github-preview".fns.stop() end,
    },
    {
        name = "markview",
        trig = "markdown",
        start = "Markview",
        stop = "",
    },
    {
        name = 'live-server',
        trig = 'html',
        start = "LiveServerStart",
        stop = "LiveServerStop",
    },
    {
        name = 'nvim-asciidoc-preview',
        trig = 'asciidoc',
        start = "AsciiDocPreview",
        stop = "AsciiDocPreviewStop",
    },
    {
        name = "peek",
        trig = "markdown",
        start = function() require "peek".open() end,
        stop = function() require "peek".close() end,
    },
    { trig = "pdf",  start = M.system_open, name = "builtin" },
    { trig = "svg",  start = M.system_open, name = "builtin" },
    { trig = "png",  start = M.system_open, name = "builtin" },
    { trig = "tif",  start = M.system_open, name = "builtin" },
    { trig = "tiff", start = M.system_open, name = "builtin" },
    { trig = "jpeg", start = M.system_open, name = "builtin" },
    { trig = "html", start = M.system_open, name = "builtin" },
    { trig = "gif",  start = M.system_open, name = "builtin" },
    { trig = "jpg",  start = M.system_open, name = "builtin" },
    { trig = "webp", start = M.system_open, name = "builtin" },
}

return M
