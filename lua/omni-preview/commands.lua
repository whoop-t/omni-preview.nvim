local defaults = require("omni-preview.defaults")
local ui = require("omni-preview.ui")

local M = {}

M.stop = function()
    local useable_previews = defaults.get_triggerable_previews()

    if not useable_previews then
        return
    end

    -- Only pop ui if there are multiple options
    if #useable_previews > 1 then
        ui.create_float_window(useable_previews, "Stop Preview", defaults.stop_preview)
    else
        defaults.stop_preview(useable_previews[1])
    end
end

M.start = function()
    local useable_previews = defaults.get_triggerable_previews()

    if not useable_previews then
        return
    end

    -- Only pop ui if there are multiple options
    if #useable_previews > 1 then
        ui.create_float_window(useable_previews, "Start Preview", defaults.start_preview)
    else
        defaults.start_preview(useable_previews[1])
    end
end

return M
