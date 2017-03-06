{ stdenv, fetchzip, fetchurl, lib } :

let
  version = "0.2.1";
  arch = if (stdenv.system == "x86_64-linux" || stdenv.isDarwin) then "amd64" else "386";
  sys = if stdenv.isDarwin then "darwin" else "linux";
  ext = if stdenv.isDarwin then "zip" else "tar.gz";
  sha = if stdenv.isDarwin then "1b6if0l7qjbiakgzgx6yzkdyasxfh0sma5w28475m0xx6vr4cbil" else "1n2w7swn9za2iq0c5ma8fr4fj2cnsn13wsjlbd7g4pl0wczgqqz7";
  src = (if stdenv.isDarwin then fetchzip else fetchurl) {
    url = "https://github.com/mroth/scmpuff/releases/download/v${version}/scmpuff_${version}_${sys}_${arch}.${ext}";
    sha256 = sha;
  };
in
stdenv.mkDerivation rec {
  inherit src;
  inherit version;

  name = "scmpuff-${version}";

  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp scmpuff $out/bin/scmpuff
  '';

  meta = {
    description = "Add numbered shortcuts to common git commands";
    homepage = "https://github.com/mroth/scmpuff";
    license = stdenv.lib.licenses.mit;
  };
}

