local path = io.popen("poetry env info -e 2>/dev/null"):read()
if path ==nil or path == "" then
        return {}
end

return {
        settings = {
                python = { pythonPath = path }
        }
}
