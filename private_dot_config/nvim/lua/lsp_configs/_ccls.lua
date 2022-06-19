local home = os.getenv('HOME')
return {
        init_options = {
                cache = {
                        directory = home .. "/.ccls-cache",
                        retainInMemory = 0,
                },
        }
}
