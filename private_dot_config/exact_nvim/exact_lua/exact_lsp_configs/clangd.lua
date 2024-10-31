return {
        cmd = {
                "clangd",
                "--offset-encoding=utf-16",
                "--completion-style=detailed",
        },
        root_dir = require("lspconfig.util").root_pattern(
                "build/compile_commands.json",
                "compile_commands.json",
                ".git"),
}
