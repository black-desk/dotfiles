return {
        settings = {
                python = { pythonPath = io.popen("poetry env info -e"):read() }
        }
}
