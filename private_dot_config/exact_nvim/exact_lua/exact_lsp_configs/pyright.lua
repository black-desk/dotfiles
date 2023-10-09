local path = io.popen("poetry env info -e 2>/dev/null"):read()
if path == "" then
        return {}
end

return {
        settings = {
                python = { pythonPath = path }
        }
}
