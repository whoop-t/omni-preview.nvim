local M = {}
function M.setup(opts)
    opts = opts or {}
    local defaults = require("omni-preview.defaults")
    local commands = require("omni-preview.commands")
    local extras = require("omni-preview.extras")
    extras.setup()
    M.previews = vim.tbl_deep_extend("force", defaults.previews, opts.previews or {})
    M.previews = vim.tbl_deep_extend("force", M.previews, extras.previews or {})
    vim.api.nvim_create_user_command("OmniPreviewStart", commands.start, { desc = "Start preview for current filetype" })
    vim.api.nvim_create_user_command("OmniPreviewStop", commands.stop, { desc = "Stop preview for current filetype" })
    vim.api.nvim_create_user_command("OmniPreviewToggle", commands.toggle,
        { desc = "Toggle preview for current filetype" })
end

return M
