{ config, pkgs, ... }:

let
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
  {
    environment.systemPackages = with pkgs; [
      pureZsh
    ];

    programs.zsh = {
      enable = true;
      enableBashCompletion = true;
      enableFzfCompletion = true;
      enableFzfGit = true;
      enableFzfHistory = true;

      enableSyntaxHighlighting = true;

      promptInit = ''
        # enable my pure prompt fork
        fpath+=( "${pureZsh.out}/share/zsh/site-functions" $fpath )

        autoload -U promptinit && promptinit
        prompt pure

        # show archey when prompt loads
        archey
      '';

      interactiveShellInit = "source ${./interactiveInit.zsh}";
    };

    environment.shellAliases = {
      v = "vim";
      vi = "vim";
      ls = "ls --color=auto --group-directories-first";
      l = "ls";
      mv = "mv -i";
      cp = "cp -i";
      rm = "rm -i";
      c = "clear && archey";
      cls = "clear && archey && ls";
      gc = "git commit";
      wlog = "git log --decorate --oneline";
      gl = "git log --decorate";
      ggp = "git grep";
      gcob = "git checkout -b";
      gps = "git push";
      grb = "git rebase";
      gsh = "git show";
      gcp = "git cherry-pick";
      gd = "git diff";
      gf = "git fetch";
      gcl = "git clone";
      gb = "git branch";
    };

    environment.variables = {
      PATH = "$PATH:~/.cargo/bin:~/go_appengine:~/.cabal/bin:/usr/local/opt/ruby/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/usr/local/share/npm/bin:/usr/texbin:/Users/bkase/android-sdk/tools:/Users/bkase/android-sdk/platform-tools:/Users/bkase/android-ndk-r9b:/Users/bkase/google-cloud-sdk/bin:~/bin:/Users/bkase/.local/bin:/Library/TeX/texbin";
    };

  }
