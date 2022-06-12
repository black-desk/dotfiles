let
  pkgs = import <nixpkgs> { };
in
{
  inherit (pkgs)
    ccls
    chezmoi
    fzf
    git
    git-review
    gopls
    lazygit
    nix-tree
    pandoc
    pyright
    rnix-lsp
    rust-analyzer
    sumneko-lua-language-server
    texlab
    ;
  inherit (pkgs.nodePackages)
    bash-language-server
    vscode-json-languageserver
    ;
}
