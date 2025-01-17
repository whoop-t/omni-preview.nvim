local M = {}

function M.setup()
    -- Function to safely require and setup a module
    local function safe_require(module_name, setup_args)
        local status, module = pcall(require, module_name)
        if status and module and module.setup then
            module.setup(setup_args or {})
        end
    end

    -- Configure each module
    safe_require("typst-preview")
    safe_require("vimtex")
    safe_require("peek", { app = "browser" })
    safe_require("csvview", {
        view = {
            spacing = 2,
            display_mode = "border",
        },
    })
end

return M
