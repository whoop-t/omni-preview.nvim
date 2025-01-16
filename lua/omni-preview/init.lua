local M = {}
M.running = false

function M.preview()
    local ft = vim.bo.filetype
    local fe = vim.fn.expand("%:e")
    local trig = false
    for _, p in ipairs(M.previews or {}) do
        if type(p.trig) == "string" then
            if p.trig == ft or p.trig == fe then
                trig = true
            end
        elseif type(p.trig == "function") then
            if p.trig() then
                trig = true
            end
        end

        if trig then
            if type(p.cmd) == "string" then
                vim.cmd(p.cmd)
                return
            elseif type(p.cmd) == "function" then
                p.cmd()
                return
            else
                vim.notify(
                    "Invalid preview command for filetype: " .. ft,
                    vim.log.levels.ERROR
                )
                return
            end
        end
    end

    vim.notify(
        "No preview available for filetype: " .. ft,
        vim.log.levels.WARN
    )
end

function M.setup(opts)
    opts = opts or {}
    local keybind = opts.keybind or "<leader>p"
    local silent = opts.silent or false
    local defaults = require("omni-preview.defaults")
    M.previews = vim.tbl_deep_extend("force", defaults.previews, opts.previews or {})
    vim.api.nvim_create_user_command("OmniPreview", M.preview, { desc = "Preview current filetype" })
    vim.keymap.set("n", keybind, ":OmniPreview<CR>", {
        silent = silent,
        desc = "Preview file using OmniPreview",
    })
end

return M
