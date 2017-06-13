{ config, lib, pkgs, ... }:
let
  fastarcheyosx = pkgs.callPackage ./src/fastarcheyosx/c.nix {};
  scmpuff = pkgs.callPackage ./src/scmpuff/c.nix {};
  highlight = pkgs.callPackage ./src/highlight/c.nix {};
in
{
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 12;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  imports = [
    ./src/zsh/c.nix
    ./src/vim/c.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: rec {
    coq = pkgs.coq.override {
      csdp = null;
    };
  };

  environment.systemPackages = with pkgs; [
    cmake
    fastarcheyosx
    scmpuff
    highlight
    watchman

    ocaml
    opam
    ocamlPackages.merlin
    ocamlPackages.camlp4

    coq

    asciinema
    fzf
    gettext
    git
    ripgrep
    jq
    arcanist
    wget
    coreutils
    go
    fasd

    nix-repl
    nox
  ];

  environment.extraOutputsToInstall = [ "man" ];

  # For some reason I get nix build errors when this is enabled
  nix.requireSignedBinaryCaches = false;

  services.activate-system.enable = true;
}
