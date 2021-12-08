
     ______   _______  _______  _______  ___   ___      _______  _______ 
    |      | |       ||       ||       ||   | |   |    |       ||       |
    |  _    ||   _   ||_     _||    ___||   | |   |    |    ___||  _____|
    | | |   ||  | |  |  |   |  |   |___ |   | |   |    |   |___ | |_____ 
    | |_|   ||  |_|  |  |   |  |    ___||   | |   |___ |    ___||_____  |
    |       ||       |  |   |  |   |    |   | |       ||   |___  _____| |
    |______| |_______|  |___|  |___|    |___| |_______||_______||_______|

This repo hold my config file.

Thanks twpayne's [chezmoi](https://github.com/twpayne/chezmoi).

## INSTALL

create file ~/.config/chezmoi/chezmoi.toml like this:

```toml
[data]
  username = ""

  # https://github.com/xalanq/cf-tool
  workspace = ""

  # https://github.com/black-desk/markpress
  wordpress_url="" # https://black-desk.cn
  wordpress_username=""
  wordpress_pwd=""

  # git
  email=""
  github_username=""

  # https://github.com/ZSaberLv0/ZFVimIM
  github_token=""
```

then run:

```bash
chezmoi init --apply black-desk
```

## TODO

  - [ ] add requirements
