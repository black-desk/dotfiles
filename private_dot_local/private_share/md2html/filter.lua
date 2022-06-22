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

local function basename(str)
        local name = string.gsub(str, "(.*/)(.*)", "%2")
        return name
end

local ext_table = {
        protobuf = {
                "*\\.proto",
        },
        m4 = {
                "*\\.m4",
        },
        xml = {
                "*\\.docbook",
                "*\\.rc",
                "*\\.daml",
                "*\\.rdf",
                "*\\.rss",
                "*\\.xspf",
                "language\\.xsd",
                "*\\.svg",
                "*\\.ui",
                "*\\.kcfg",
                "*\\.qrc",
                "*\\.wsdl",
                "*\\.scxml",
                "*\\.xbel",
                "*\\.dae",
                "*\\.sch",
                "*\\.brd",
        },
        systemverilog = {
                "*\\.sv",
                "*\\.svh",
        },
        idris = {
                "*\\.idr",
        },
        coffee = {
                "Cakefile",
                "*\\.coffee",
                "*\\.coco",
                "*\\.cson",
        },
        bash = {
                "get_ext\\.sh",
                "validatehl\\.sh",
                "*\\.bash",
                "*\\.ebuild",
                "*\\.eclass",
                "*\\.exlib",
                "*\\.exheres-0",
                "\\.bashrc",
                "\\.bash_profile",
                "\\.bash_login",
                "\\.profile",
                "PKGBUILD",
                "APKBUILD",
        },
        gnuassembler = {
                "*\\.s",
                "*\\.S",
        },
        alert = {
        },
        postscript = {
                "*\\.ps",
                "*\\.ai",
                "*\\.eps",
        },
        mandoc = {
                "*\\.1",
                "*\\.2",
                "*\\.3",
                "*\\.4",
                "*\\.5",
                "*\\.6",
                "*\\.7",
                "*\\.8",
                "*\\.1m",
                "*\\.3x",
                "*\\.tmac",
        },
        graphql = {
                "*\\.graphql",
        },
        objectivec = {
                "*\\.m",
                "*\\.h",
        },
        awk = {
                "*\\.awk",
        },
        eiffel = {
                "*\\.e",
        },
        latex = {
                "*\\.tex",
                "*\\.ltx",
                "*\\.dtx",
                "*\\.sty",
                "*\\.cls",
                "*\\.bbx",
                "*\\.cbx",
                "*\\.lbx",
                "*\\.tikz",
                "*\\.pgf",
        },
        cs = {
                "*\\.cs",
        },
        typescript = {
                "*\\.ts",
        },
        octave = {
                "*\\.octave",
                "*\\.m",
                "*\\.M",
        },
        gcc = {
                "*\\.c++",
                "*\\.cxx",
                "*\\.cpp",
                "*\\.cc",
                "*\\.C",
                "*\\.h",
                "*\\.hh",
                "*\\.H",
                "*\\.h++",
                "*\\.hxx",
                "*\\.hpp",
                "*\\.hcc",
        },
        python = {
                "*\\.py",
                "*\\.pyw",
                "SConstruct",
                "SConscript",
                "*\\.FCMacro",
        },
        elm = {
                "*\\.elm",
        },
        qml = {
                "*\\.qml",
                "*\\.qmltypes",
        },
        mips = {
                "*\\.s",
        },
        nix = {
                "*\\.nix",
        },
        lex = {
                "*\\.l",
                "*\\.lex",
                "*\\.flex",
        },
        diff = {
                "*\\.diff",
                "haskell\\.xml.patch",
                "lua\\.xml.patch",
                "markdown\\.xml.patch",
                "php\\.xml.patch",
                "*\\.rej",
        },
        haskell = {
                "*\\.hs",
                "*\\.chs",
                "*\\.hs-boot",
        },
        objectivecpp = {
                "*\\.mm",
                "*\\.M",
                "*\\.h",
        },
        yacc = {
                "*\\.y",
                "*\\.yy",
                "*\\.ypp",
                "*\\.y++",
        },
        php = {
        },
        xorg = {
                "xorg\\.conf",
        },
        lilypond = {
                "*\\.ly",
                "*\\.LY",
                "*\\.ily",
                "*\\.ILY",
                "*\\.lyi",
                "*\\.LYI",
        },
        mathematica = {
                "*\\.nb",
        },
        sgml = {
                "*\\.sgml",
        },
        sml = {
                "*\\.sml",
                "*\\.ml",
        },
        isocpp = {
                "*\\.c++",
                "*\\.cxx",
                "*\\.cpp",
                "*\\.cc",
                "*\\.C",
                "*\\.h",
                "*\\.hh",
                "*\\.H",
                "*\\.h++",
                "*\\.hxx",
                "*\\.hpp",
                "*\\.hcc",
                "*\\.moc",
        },
        vhdl = {
                "*\\.vhdl",
                "*\\.vhd",
        },
        asn1 = {
                "*\\.asn",
                "*\\.asn1",
        },
        elixir = {
                "*\\.ex",
                "*\\.exs",
                "*\\.eex",
                "*\\.xml.eex",
                "*\\.js.eex",
        },
        ruby = {
                "*\\.rb",
                "*\\.rjs",
                "*\\.rxml",
                "*\\.xml.erb",
                "*\\.js.erb",
                "*\\.rake",
                "Rakefile",
                "Gemfile",
                "*\\.gemspec",
                "Vagrantfile",
        },
        mustache = {
                "*\\.mustache",
                "*\\.handlebars",
                "*\\.hbs",
                "*\\.ractive",
                "*\\.hogan",
                "*\\.hulk",
                "*\\.html.mst",
                "*\\.html.mu",
                "*\\.html.rac",
        },
        tcsh = {
                "*\\.csh",
                "*\\.tcsh",
                "csh\\.cshrc",
                "csh\\.login",
                "\\.tcshrc",
                "\\.cshrc",
                "\\.login",
        },
        html = {
                "*\\.htm",
                "*\\.html",
                "*\\.shtml",
                "*\\.shtm",
        },
        sass = {
                "*\\.sass",
        },
        noweb = {
                "*\\.w",
                "*\\.nw",
        },
        boo = {
                "*\\.boo",
        },
        powershell = {
                "*\\.ps1",
                "*\\.psm1",
                "*\\.psd1",
        },
        swift = {
                "*\\.swift",
        },
        haxe = {
                "*\\.hx",
                "*\\.Hx",
                "*\\.hX",
                "*\\.HX",
        },
        pure = {
                "*\\.pure",
        },
        raku = {
                "*\\.raku",
                "*\\.rakumod",
                "*\\.rakudoc",
                "*\\.rakutest",
                "*\\.pl6",
                "*\\.PL6",
                "*\\.p6",
                "*\\.pm6",
                "*\\.pod6",
        },
        ["modula-2"] = {
                "*\\.mod",
                "*\\.def",
        },
        purebasic = {
                "*\\.pb",
                "*\\.pbi",
        },
        ["javascript-react"] = {
                "*\\.jsx",
        },
        d = {
                "*\\.d",
                "*\\.D",
                "*\\.di",
                "*\\.DI",
        },
        perl = {
                "*\\.pl",
                "*\\.PL",
                "*\\.pm",
        },
        opencl = {
                "*\\.cl",
        },
        ada = {
                "*\\.adb",
                "*\\.ads",
                "*\\.ada",
                "*\\.a",
        },
        dockerfile = {
                "Dockerfile",
        },
        javascript = {
                "*\\.js",
                "*\\.kwinscript",
                "*\\.julius",
        },
        css = {
                "*\\.css",
        },
        scala = {
                "*\\.scala",
                "*\\.sbt",
        },
        lua = {
                "1\\.lua",
        },
        rhtml = {
                "*\\.rhtml",
                "*\\.RHTML",
                "*\\.html.erb",
        },
        tcl = {
                "*\\.tcl",
                "*\\.tk",
        },
        apache = {
                "httpd\\.conf",
                "httpd2\\.conf",
                "apache\\.conf",
                "apache2\\.conf",
                "\\.htaccess*",
                "\\.htpasswd*",
        },
        zsh = {
                "get_ext\\.sh",
                "validatehl\\.sh",
                "*\\.zsh",
                "\\.zshrc",
                "\\.zprofile",
                "\\.zlogin",
                "\\.zlogout",
                "\\.profile",
        },
        sci = {
                "*\\.sci",
                "*\\.sce",
        },
        llvm = {
                "*\\.ll",
        },
        curry = {
                "*\\.curry",
        },
        ats = {
                "*\\.dats",
                "*\\.sats",
                "*\\.hats",
        },
        go = {
                "*\\.go",
        },
        povray = {
                "*\\.inc",
                "*\\.pov",
        },
        changelog = {
                "ChangeLog",
        },
        ini = {
                "*\\.ini",
                "*\\.pls",
                "*\\.kcfgc",
        },
        verilog = {
                "*\\.v",
                "*\\.V",
                "*\\.vl",
        },
        clojure = {
                "*\\.clj",
                "*\\.cljs",
                "*\\.cljc",
        },
        matlab = {
                "*\\.m",
                "*\\.M",
        },
        asp = {
                "*\\.asp",
        },
        bibtex = {
                "*\\.bib",
        },
        markdown = {
                "*\\.md",
                "*\\.mmd",
                "*\\.markdown",
        },
        relaxngcompact = {
                "*\\.rnc",
        },
        nim = {
                "*\\.nim",
        },
        ["fortran-free"] = {
                "*\\.f90",
                "*\\.F90",
                "*\\.f95",
                "*\\.F95",
                "*\\.f03",
                "*\\.F03",
                "*\\.f08",
                "*\\.F08",
        },
        fasm = {
                "*\\.asm",
                "*\\.inc",
                "*\\.fasm",
        },
        c = {
                "*\\.c",
                "*\\.C",
                "*\\.h",
        },
        scss = {
                "*\\.scss",
        },
        maxima = {
                "*\\.mac",
                "*\\.MAC",
                "*\\.dem",
                "*\\.DEM",
        },
        texinfo = {
                "*\\.texi",
        },
        cmake = {
                "CMakeLists\\.txt",
                "*\\.cmake",
                "*\\.cmake.in",
        },
        prolog = {
                "*\\.prolog",
                "*\\.dcg",
                "*\\.pro",
        },
        pascal = {
                "*\\.p",
                "*\\.pas",
                "*\\.pp",
        },
        sql = {
                "*\\.sql",
                "*\\.SQL",
                "*\\.ddl",
                "*\\.DDL",
        },
        yaml = {
                "*\\.yaml",
                "*\\.yml",
        },
        ["literate-haskell"] = {
                "*\\.lhs",
        },
        java = {
                "*\\.java",
        },
        actionscript = {
                "*\\.as",
        },
        xslt = {
                "*\\.xsl",
                "*\\.xslt",
        },
        javadoc = {
        },
        erlang = {
                "*\\.erl",
        },
        orgmode = {
                "*\\.org",
        },
        groovy = {
                "*\\.groovy",
                "*\\.gradle",
                "*\\.gvy",
                "Jenkinsfile",
        },
        abc = {
                "*\\.abc",
                "*\\.ABC",
        },
        coldfusion = {
                "*\\.cfm",
                "*\\.cfc",
                "*\\.cfml",
                "*\\.dbm",
        },
        scheme = {
                "*\\.scm",
                "*\\.ss",
                "*\\.scheme",
                "*\\.guile",
                "*\\.chicken",
                "*\\.meta",
        },
        djangotemplate = {
                "*\\.htm",
                "*\\.html",
        },
        stan = {
                "*\\.stan",
                "*\\.stanfunctions",
        },
        dtd = {
                "*\\.dtd",
        },
        nasm = {
                "*\\.asm",
        },
        stata = {
                "*\\.do",
                "*\\.ado",
                "*\\.doh",
                "*\\.DO",
                "*\\.ADO",
                "*\\.DOH",
        },
        relaxng = {
                "*\\.rng",
                "*\\.RNG",
        },
        glsl = {
                "*\\.glsl",
                "*\\.vert",
                "*\\.vs",
                "*\\.frag",
                "*\\.fs",
                "*\\.geom",
                "*\\.gs",
                "*\\.tcs",
                "*\\.tes",
        },
        hamlet = {
                "*\\.hamlet",
        },
        rest = {
                "*\\.rst",
        },
        r = {
                "*\\.R",
                "*\\.r",
                "*\\.S",
                "*\\.s",
                "*\\.q",
        },
        ["modula-3"] = {
                "*\\.m3",
                "*\\.i3",
                "*\\.ig",
                "*\\.mg",
        },
        default = {
                "*\\.txt",
        },
        j = {
                "*\\.ijs",
                "*\\.ijt",
                "*\\.IJS",
                "*\\.IJT",
        },
        roff = {
        },
        julia = {
                "*\\.jl",
        },
        cpp = {
                "*\\.c++",
                "*\\.cxx",
                "*\\.cpp",
                "*\\.cc",
                "*\\.C",
                "*\\.cu",
                "*\\.h",
                "*\\.hh",
                "*\\.H",
                "*\\.h++",
                "*\\.hxx",
                "*\\.hpp",
                "*\\.hcc",
                "*\\.cuh",
                "*\\.inl",
                "*\\.ino",
                "*\\.pde",
                "*\\.moc",
        },
        sed = {
                "*\\.sed",
        },
        dot = {
                "*\\.dot",
        },
        pike = {
                "*\\.pike",
        },
        ["fortran-fixed"] = {
                "*\\.f",
                "*\\.F",
                "*\\.for",
                "*\\.FOR",
                "*\\.fpp",
                "*\\.FPP",
        },
        monobasic = {
                "*\\.vb",
        },
        metafont = {
                "*\\.mp",
                "*\\.mps",
                "*\\.mpost",
                "*\\.mf",
        },
        doxygen = {
                "*\\.dox",
                "*\\.doxygen",
        },
        json = {
                "*\\.json",
                "\\.kateproject",
                "\\.arcconfig",
                "*\\.geojson",
                "*\\.gltf",
                "*\\.theme",
        },
        rust = {
                "*\\.rs",
        },
        mediawiki = {
                "*\\.mediawiki",
        },
        fsharp = {
                "*\\.fs",
                "*\\.fsi",
                "*\\.fsx",
        },
        ocaml = {
                "*\\.ml",
                "*\\.mli",
        },
        ["sql-mysql"] = {
                "*\\.sql",
                "*\\.SQL",
                "*\\.ddl",
                "*\\.DDL",
        },
        modelines = {
        },
        ["sql-postgresql"] = {
                "*\\.sql",
                "*\\.SQL",
                "*\\.ddl",
                "*\\.DDL",
        },
        email = {
                "*\\.eml",
                "*\\.email",
                "*\\.emlx",
                "*\\.mbox",
                "*\\.mbx",
        },
        toml = {
                "*\\.toml",
        },
        jsp = {
                "*\\.jsp",
                "*\\.JSP",
        },
        makefile = {
                "GNUmakefile",
                "Makefile",
                "makefile",
                "GNUmakefile\\.*",
                "Makefile\\.*",
                "makefile\\.xml",
                "*\\.mk",
        },
        kotlin = {
                "*\\.kt",
                "*\\.kts",
        },
        doxygenlua = {
        },
        xul = {
                "*\\.xul",
                "*\\.xbl",
        },
        ["literate-curry"] = {
                "*\\.lcurry",
        },
        agda = {
                "*\\.agda",
        },
        commonlisp = {
                "*\\.lisp",
                "*\\.cl",
                "*\\.lsp",
        }
}

local function get_filetype(file)
        file = basename(file)
        for type, matches in ipairs(ext_table) do
                for _, match in ipairs(matches) do
                        if file:find(match) ~= nil then
                                return type
                        end
                end
        end
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
                                if dir == nil then
                                        dir = "./"
                                end
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
                                                { class = filetype }))
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
