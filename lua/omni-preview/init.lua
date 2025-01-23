local M = {}

M.command = function(opts)
    local commands = require("omni-preview.commands")
    local sub = opts.args
    if commands[sub] then
        commands[sub](opts)
    else
        print("Invalid subcommand" .. sub)
    end
end


function M.setup(opts)
    opts = opts or {}
    local defaults = require("omni-preview.defaults").previews
    M.previews = vim.tbl_deep_extend("force", defaults, opts.previews or {})
    vim.api.nvim_create_user_command("OmniPreview", M.command,
        {
            nargs = 1,
            complete = function()
                return { "start", "stop", "toggle" }
            end,
            desc = "Control preview for the current filetype: start, stop, or toggle"
        }
    )
end

return M
