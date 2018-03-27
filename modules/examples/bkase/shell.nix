with import <nixpkgs> { };

let
  scmpuff = pkgs.callPackage ./src/scmpuff/c.nix {};
  highlight = pkgs.callPackage ./src/highlight/c.nix {};
  vimrc = pkgs.callPackage ./src/vim/vimrc.nix {};
  zshSyntaxHighlighting =
    let
      fromGithub = fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-syntax-highlighting";
        rev = "c19ee583138ebab416b0d2efafbad7dc9f3f7c4f";
        sha256 = "0awdgdh9swv1as8jb71nda0x32r4lram47m3wqbjpjgsy9a018i7";
      };
    in
    stdenv.mkDerivation rec {
      name = "zsh-syntax-highlighting-${version}";
      version = "0.4.1";
      src = fromGithub;

      buildInputs = [ ];

      installPhase = ''
        mkdir -p $out/share/zsh/zsh-syntax-highlighting
        cp -r . $out/share/zsh/zsh-syntax-highlighting
      '';

      meta = {
        description = "Fish shell like syntax highlighting for Zsh.";
        homepage = "https://github.com/zsh-users/zsh-syntax-highlighting";
        license = stdenv.lib.licenses.bsd3;
      };
    };
  vimrcConfig = {
    vam.knownPlugins = pkgs.vimPlugins;
    vam.pluginDictionaries = [
      { names = [
        "vim-addon-nix"
        "youcompleteme"
        "surround"
        "Solarized"
        "The_NERD_Commenter"
        "fzf-vim"
        "fzfWrapper"
        "syntastic"
        "lightline-vim"

        "gitgutter"
        "fugitive"
        "vim-markdown"

        "neomake"
        "vimproc"
      ];}
    ];
    customRC = vimrc.config;
  };
  myVim = pkgs.vim_configurable.customize { name = "vim"; inherit vimrcConfig; };
  archeyProg = screenfetch;
  pureZshSrc = pkgs.fetchFromGitHub {
    owner = "bkase";
    repo = "pure";
    rev = "73c37b738ef5fa608404d827ba274e1c43a73a8f";
    sha256 = "0dbdkbvx5jbfjax02hllrbkaz6zc1b2a91953k63yyh8m5f9k6cv";
  };
  pureZsh = pkgs.stdenvNoCC.mkDerivation rec {
    name = "pure-zsh-${version}";
    version = "2017-03-04";
    phases = [ "unpackPhase" "installPhase" "fixupPhase" ];
    src = pureZshSrc;

    installPhase = ''
      mkdir -p $out/share/zsh/site-functions
      cp pure.zsh $out/share/zsh/site-functions/prompt_pure_setup
      cp async.zsh $out/share/zsh/site-functions/async
    '';
  };
in
stdenv.mkDerivation rec {
  version = "0.1.0";

  name = "life-${version}";

  buildInputs = [
    cmake
    bsdiff
    archeyProg
    zsh
    myVim
    pureZsh
    zshSyntaxHighlighting
    rustc
    cargo

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
}
