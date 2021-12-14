
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

## TOOLS

  * `~/.tools`: this directory holds some scripts
    * `bin`: the scripts themselves
      * `uniontech`: scripts that relay to deepin/uniontech
      * `mkde`: make chroot environment for debian (based distro)
      * `dein`: chroot into debian environment
      * `deout`: clean up things after exit from debian environment
    * `static`: some static file used by scripts

## TODO

  - [ ] add requirements
