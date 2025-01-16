local M = {}

function M.preview()
    for _, extra in ipairs(M.extras or {}) do
        if extra.trigger() then
            extra.preview()
            return
        end
    end

    local ft = vim.bo.filetype
    local preview = M.previews[ft]
    if preview then
        if type(preview.command) == "string" then
            vim.cmd(preview.command)
        elseif type(preview.command) == "function" then
            preview.command()
        else
            vim.notify(
                "Invalid preview command for filetype: " .. ft,
                vim.log.levels.ERROR
            )
        end
    else
        vim.notify(
            "No preview available for filetype: " .. ft,
            vim.log.levels.WARN
        )
    end
end

M.default_system_open = function()
    local filename = vim.fn.expand("%:p")
    local success = os.execute("open " .. filename)
    if not success then
        print("Command failed!")
    end
end

function M.setup(opts)
    opts = opts or {}
    local keybind = opts.keybind or "<leader>p"
    local silent = opts.silent or false
    local npm = require("omni-preview.npm")

    local default_previews = {
        markdown = { command = function() require "peek".open() end },
        typst = { command = "TypstPreview" },
        pdf = { command = M.default_system_open },
        png = { command = M.default_system_open },
        jpeg = { command = M.default_system_open },
        csv = { command = "CsvViewEnable" },
        -- node = { command = b.preview}
    }

    -- Merge user-provided previews with defaults
    M.previews = vim.tbl_deep_extend("force", default_previews, opts.previews or {})
    M.extras = {
        { trigger = npm.trigger, preview = npm.preview }
    }

    vim.api.nvim_create_user_command("OmniPreview", M.preview, { desc = "Preview current filetype" })
    vim.keymap.set("n", keybind, ":OmniPreview<CR>", {
        silent = silent,
        desc = "Preview file using OmniPreview",
    })
end

return M
