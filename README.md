     ______   _______  _______  _______  ___   ___      _______  _______
    |      | |       ||       ||       ||   | |   |    |       ||       |
    |  _    ||   _   ||_     _||    ___||   | |   |    |    ___||  _____|
    | | |   ||  | |  |  |   |  |   |___ |   | |   |    |   |___ | |_____
    | |_|   ||  |_|  |  |   |  |    ___||   | |   |___ |    ___||_____  |
    |       ||       |  |   |  |   |    |   | |       ||   |___  _____| |
    |______| |_______|  |___|  |___|    |___| |_______||_______||_______|

This repo hold my config file.

Currently it's only aims to arch linux.

## INSTALL

1. Create file ~/.config/chezmoi/chezmoi.toml like this:

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

2. Install [yay](https://github.com/Jguer/yay):

Refer to [installation guide](https://github.com/Jguer/yay#installation), you should run:

```bash
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

3. Install [chezmoi](https://github.com/twpayne/chezmoi):

```bash
sudo pacman -Syu chezmoi
```

4. Run:

```bash
chezmoi init --apply black-desk
yay -S - < ~/.local/share/chezmoi/requirements.txt
```

## TOOLS

  * `~/.tools`: this directory holds some scripts
    * `bin`: the scripts themselves
      * `uniontech`: scripts that relay to deepin/uniontech
      * `mkde`: make chroot environment for debian (based distro)
      * `dein`: chroot into debian environment
    * `static`: some static file used by scripts

## TODO

  - [x] add requirements
  - [ ] add auto generated requirements
  - [ ] use which-key config key mappings
