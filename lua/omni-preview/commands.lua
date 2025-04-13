local defaults = require("omni-preview.defaults")
local ui = require("omni-preview.ui")

local M = {}

M.stop = function()
    local running_plugins = defaults.find_running_previews()

    if not running_plugins then
        return
    end

    if #running_plugins > 1 then
      ui.create_float_window(running_plugins)
    else
      defaults.stop_preview(running_plugins[1])
    end
end

M.toggle = function()
    local rp = defaults.find_running_previews()

    if not rp then
        M.start()
    else
        M.stop()
    end
end

M.start = function()
    local useable_previews = defaults.get_triggerable_previews()

    if not useable_previews then
        return
    end

    if #useable_previews > 1 then
      ui.create_float_window(useable_previews)
    else
      defaults.start_preview(useable_previews[1])
    end
end

return M
