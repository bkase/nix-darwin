{ config, pkgs, ... }:

{
  programs.vim.plugins = [ { names = [
     "coquille"
     "vimbufsync"

     "vim-addon-nix"
     "youcompleteme"
     "lightline-vim"
     "surround"
     "Solarized"
     "The_NERD_Commenter"
     "fzf-vim"
     "fzfWrapper"

     "vim-elixir"

     "vim-flow"
     "vim-javascript"
     "vim-jsx"
     "emmet-vim"
     "psc-ide-vim"
     "purescript-vim"
     "vim-jinja"
     "vim-reason-loader"

     "gitgutter"
     "fugitive"
     "vim-markdown"

     "neomake"
     "vimproc"

     "idris-vim"
  ]; } ];

  programs.vim.extraKnownPlugins = ({
    vimbufsync = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "vimbufsync-2017-05-08";
      src = pkgs.fetchgit {
        url = "git://github.com/let-def/vimbufsync";
        rev = "650f9aefecd1aa00dfe4ceb60a623096951ec3dc";
        sha256 = "1wx9687hw833b6m5xhw8ig3ik9k9ccxrc628cfx41ay48vzyfbip";
      };
    };

    coquille = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "coquille-2017-03-22";
      src = pkgs.fetchgit {
        url = "git://github.com/the-lambda-church/coquille";
        rev = "39990d139519d0aa46e976402f2b2dee0c41f33d";
        sha256 = "0vscnh7qy2b7r2raswjynpzhv3vh8ws2ig7y98vqmghr3d4yfy88";
      };
    };

    vim-reason-loader = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "vim-reason-loader-2017-04-29";
      src = pkgs.fetchgit {
        url = "git://github.com/reasonml/vim-reason-loader";
        rev = "52dec4a6fd2a1d1dcc270b7360b135cd41acca0f";
        sha256 = "14wpqam370k64q2ivq3wvbhgml4gglzza8hvdz2x6dbhy473linv";
      };
    };

    lightline-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "vim-lightline-2017-02-13";
      src = pkgs.fetchgit {
        url = "git://github.com/itchyny/lightline.vim";
        rev = "a63a00d548fd20457a4f31d31fb9c8fe8a7ebc2a";
        sha256 = "13fpf1rdaswz5c3wgpc1jjrzw47jhm896q5z0dc82lrfwsggp5a5";
      };
      dependencies = [];
    };

    vim-jsx = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "vim-jsx-2016-08-22";
      src = pkgs.fetchgit {
        url = "git://github.com/mxw/vim-jsx";
        rev = "eb656ed96435ccf985668ebd7bb6ceb34b736213";
        sha256 = "1ydyifnfk5jfnyi4a1yc7g3b19aqi6ajddn12gjhi8v02z30vm65";
      };
      dependencies = [];
    };

    vim-javascript = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "vim-javascript-1.2.5.1";
      src = pkgs.fetchgit {
        url = "git://github.com/pangloss/vim-javascript";
        rev = "e9a59c87703d7d67d9933e68b80732326163a5c5";
        sha256 = "08l7ricd3j5h2bj9i566byh39v9n5wj5mj75f2c8a5dsc732b2k7";
      };
      dependencies = [];

    };

    vim-flow = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "vim-flow-2016-10-16";
      src = pkgs.fetchgit {
        url = "git://github.com/flowtype/vim-flow";
        rev = "3bd879dd7060f13a78e9238669c2e1731e098607";
        sha256 = "002nl02187b2lxaya0myd0scn586z9r7yjklz6gawrrpx17vi49f";
      };
      dependencies = [];
    };

    emmet-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "emmet-vim-2017-01-14";
      src = pkgs.fetchgit {
        url = "git://github.com/mattn/emmet-vim";
        rev = "5442207ccb4468ee511a3ae5aa4d81839b247d24";
        sha256 = "1nprsw4qfjrgb7cmxn076ymc76m04z4qkm8w0a981mzibz51rqqd";
      };
      dependencies = [];
    };

    psc-ide-vim = pkgs.vimUtils.buildVimPluginFrom2Nix { # created by nix#NixDerivation
      name = "psc-ide-vim-2017-03-02";
      src = pkgs.fetchgit {
        url = "git://github.com/frigoeu/psc-ide-vim";
        rev = "cfd4228ff907be6124953d4ff41951ce3eca28ce";
        sha256 = "1dvdrj06l65xflq7f5k2c4awrc7hh03qr48h9i39q8lg4xc0qc1p";
      };
      dependencies = [];
    };

    purescript-vim = pkgs.vimUtils.buildVimPluginFrom2Nix { # created by nix#NixDerivation
      name = "purescript-vim-2016-08-31";
      src = pkgs.fetchgit {
        url = "git://github.com/raichoo/purescript-vim";
        rev = "2c55bcefd63bc40ed2aa9d6ce9d89a590dfa3477";
        sha256 = "1y96w8p865gd6zr29wpxn1qwsk833y06x1qp586gylgi0jp1ybzv";
      };
      dependencies = [];
    };

    vim-jinja = pkgs.vimUtils.buildVimPluginFrom2Nix { # created by nix#NixDerivation
      name = "vim-jinja-2016-11-15";
      src = pkgs.fetchgit {
        url = "git://github.com/lepture/vim-jinja";
        rev = "8d330a7aaf0763d080dc82204b4aaba6ac0605c6";
        sha256 = "1n62ga02rcj7jjgzvwr46pckj59dc1zqahjgampjcwdd8vf4mg3q";
      };
      dependencies = [];
    };

  });

}
