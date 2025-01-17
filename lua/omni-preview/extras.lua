local M = {}

M.previews = {
    { name = "typst-preview", trig = "typst", start = "TypstPreview" },
    { name = "vimtex",        trig = "tex",   start = "LatexStart" },
    {
        name = "csvview",
        trig = "csv",
        start = "CsvViewEnable",
        stop = "CsvViewDisable",
        opts = {
            view = {
                spacing = 2,
                display_mode = "border",
            },
        }
    },
    {
        name = "peek",
        trig = "markdown",
        start = function() require "peek".open() end,
        stop = function() require "peek".close() end,
        opts = { app = "browser" }
    },
}

function M.setup()
    -- Function to safely require and setup a module
    local function safe_setup(prev)
        local status, module = pcall(require, prev.name)
        if status and module and module.setup then
            module.setup(prev.opts)
        end
    end

    -- Configure each module
    for _, p in ipairs(M.previews) do
        safe_setup(p)
    end
end

return M
