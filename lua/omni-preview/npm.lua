local M = {}

function M.trig()
    local uv = vim.loop
    local cwd = uv.cwd()
    while cwd do
        local pkg_path = cwd .. "/package.json"
        if uv.fs_stat(pkg_path) then
            return true
        end
        cwd = cwd:match("(.*/)[^/]+$")
    end
    return false
end

-- goal is to find what port the localhost for the frontend it running on. Ideally running the OmniPreview command from within any file in an npm project will open the correct localhsot port for the frontend. This should be able to work in all frontend type files, svelte, tsx, vue, vanilla js, etc.
function M.cmd()
    -- there are several approaches that I can think to take for this
    -- 1. Try to find a package.json and determine what the preview scripts is.
    -- > However this has the downsides of dealing with different formats, although somewhat standard we may have to deal with node, deno, bun, pnpm, yarn, and any number of new others all the time.
    -- 2. Try to query the network somehow and trace a name back to the current working diectory?
    -- 3. Query system process and try to grep for a certain name?
    -- In both #2 and #3 we have no guarantee that the server will be running on the same machine or even the same network, or that neovim will be within the correct root directory of the project. This seems like it will be a challenging problem to solve. Maybe you have some suggestions.

    -- for now this will just be hardcoded
    os.execute([[open "http://localhost:5173/"]])
end

return M
