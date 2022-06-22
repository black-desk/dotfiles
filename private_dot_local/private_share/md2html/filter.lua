local function split(str)
        local lines = {}
        for line in string.gmatch(str, "([^\n]*)\n") do
                table.insert(lines, line)
        end
        local last = string.match(str, "^.*\n(.*[^\n])$")
        table.insert(lines, last)
        if #lines == 0 then
                return { str }
        end
        return lines
end

local function is_relative_path(path)
        local start = string.sub(path, 1, 2)
        return start == "./" or start == ".\\"
end

local function read_all(file)
        local f = io.open(file, "rb")
        if f == nil then
                return nil
        end

        local content = f:read("*all")
        f:close()
        return content
end

local function get_file_paths_from_text(text)
        return split(text)
end

local function get_filetype(file)
        return file:match("^.+%.(.+)$")
end

local function get_dir(file)
        return file:match("^(.+/).+$")
end

function CodeBlock(block)
        if block.classes[1] == "include" then
                local files = get_file_paths_from_text(block.text)
                if files == nil then
                        return block
                end

                local ret = pandoc.List({})

                for _, file in ipairs(files) do
                        if is_relative_path(file) then
                                if #PANDOC_STATE.input_files ~= 1 then
                                        print("WARNING: there are multiple input files of pandoc, please check NOTE in README.md.")
                                end

                                local dir = get_dir(PANDOC_STATE.input_files[1])
                                local filetype = get_filetype(file)

                                local abs_file_path = dir .. file
                                local content = read_all(abs_file_path)
                                if content == nil then
                                        print("WARNING: cannot read from " ..
                                                abs_file_path .. "!")
                                        return block
                                end
                                ret:insert(
                                        pandoc.CodeBlock(
                                                content,
                                                { classes = filetype }))
                        else
                                print("WARNING: only support relative path!")
                                return block
                        end
                end
                return ret
        end
end

local function startsWith(str, prefix)
        return string.sub(str, 1, string.len(prefix)) == prefix
end

function Link(el)
        if (not startsWith(el.target, "http://")) and
            (not startsWith(el.target, "https://")) then
                el.target = string.gsub(el.target, "%.md", ".html")
        end
        return el
end
