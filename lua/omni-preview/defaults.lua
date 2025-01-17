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
    { trig = "pdf",  start = M.system_open, name = "builtin" },
    { trig = "svg",  start = M.system_open, name = "builtin" },
    { trig = "png",  start = M.system_open, name = "billtin" },
    { trig = "jpeg", start = M.system_open, name = "builtin" },
    { trig = "html", start = M.system_open, name = "builtin" },
    npm,
}

return M
