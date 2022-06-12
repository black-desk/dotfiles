``` 
 ______   _______  _______  _______  ___   ___      _______  _______
|      | |       ||       ||       ||   | |   |    |       ||       |
|  _    ||   _   ||_     _||    ___||   | |   |    |    ___||  _____|
| | |   ||  | |  |  |   |  |   |___ |   | |   |    |   |___ | |_____
| |_|   ||  |_|  |  |   |  |    ___||   | |   |___ |    ___||_____  |
|       ||       |  |   |  |   |    |   | |       ||   |___  _____| |
|______| |_______|  |___|  |___|    |___| |_______||_______||_______|
```

This repo hold my config file.

Currently it's only aims to arch linux.

## INSTALL

1. Use nix package manager to install most of lsp
   
   ``` bash
   sudo pacman -S nix nix-docs
   
   sudo echo <<EOF
   
   substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/
   EOF
   
   sudo systemctl enable --now nix-daemon
   sudo usermod -aG nix-users $(whoami)
   
   nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
   nix-channel --update
   
   wget https://github.com/black-desk/dotfiles/env.nix
   nix-env -ir -f env.nix
   ```

2. Create file \~/.config/chezmoi/chezmoi.toml like this:
   
   ``` toml
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

3. Install [yay](https://github.com/Jguer/yay):
   
   Refer to [installation guide](https://github.com/Jguer/yay#installation), you
   should run:
   
   ``` bash
   pacman -S --needed git base-devel
   git clone https://aur.archlinux.org/yay.git
   cd yay
   makepkg -si
   ```

4. Install [chezmoi](https://github.com/twpayne/chezmoi):
   
   ``` bash
   sudo pacman -Syu chezmoi
   ```

5. Run:
   
   ``` bash
   chezmoi init --apply black-desk
   yay -S - < ~/.local/share/chezmoi/requirements.txt
   ```

## TOOLS

- `~/.tools`: this directory holds some scripts
  - `bin`: the scripts themselves
    - `uniontech`: scripts that relay to deepin/uniontech
    - `mkde`: make chroot environment for debian (based distro)
    - `dein`: chroot into debian environment
  - `static`: some static file used by scripts

## TODO

- [x] add requirements
- [ ] add auto generated requirements
- [ ] use which-key config key mappings

<!-- end list -->

``` 
```
