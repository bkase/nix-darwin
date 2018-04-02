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
    vam.knownPlugins = pkgs.vimPlugins // {
      "ale-1.8.0" = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "ale-1.8.0";
        src = pkgs.fetchgit {
          url = "git://github.com/w0rp/ale";
          rev = "164c711b3da5a51a2323a3bd613df251ce455ca5";
          sha256 = "135xb70cyrawp2bpwv6mnayw5s8ms8798x0mg03i0h68dhv5z8ds";
        };
      };
      lightline-ale = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "lightline-ale-2017-05-08";
        src = pkgs.fetchgit {
          url = "git://github.com/maximbaz/lightline-ale";
          rev = "9fed1e8b278364dec5acd52e034eb302dca8ce0d";
          sha256 = "0d0hvcq58nssmw82m92557azq4x6i0mz4wm640zi09whnkq5kcma";
        };
      };
    };
    vam.pluginDictionaries = [
      { names = [
        "vim-addon-nix"
        "youcompleteme"
        "surround"
        "Solarized"
        "The_NERD_Commenter"
        "fzf-vim"
        "fzfWrapper"
        "ale-1.8.0"
        "lightline-vim"
        "lightline-ale"

        "gitgutter"
        "fugitive"
        "vim-markdown"

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

    texlive.combined.scheme-full

    nix-repl
    nox
  ];
}
