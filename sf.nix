{ pkgs ? import <nixpkgs> {}, latest ? false }:

with pkgs;

let
  ## Vol 1: Logical Foundations
  lf-src = if latest
           then fetchTarball "https://softwarefoundations.cis.upenn.edu/lf-current/lf.tgz"
           else ./src/lf-2017-11-05.tgz;
  ## Vol 2: Programming Language Foundations
  plf-src = if latest
            then fetchTarball "https://softwarefoundations.cis.upenn.edu/current/plf-current/plf.tgz"
            else ./src/plf-2017-11-05.tgz;
  ## Vol 3: Verified Functional Algorithms
  vfa-src = if latest
            then fetchTarball "https://softwarefoundations.cis.upenn.edu/current/vfa-current/vfa.tgz"
            else ./src/vfa-2017-11-05.tgz;

  buildPDF = env: pkgs.stdenv.mkDerivation ({
    name = "build-pdf";
    buildInputs = [
      coq
      (texlive.combine { inherit (texlive) scheme-small cm-super enumitem preprint ucs; })
    ];
    buildPhase = ''
      make all all.pdf
    '';
    installPhase = ''
      mv -T all.pdf $out
    '';
  } // env);
in
  {
    lf  = buildPDF { src = lf-src; };
    plf = buildPDF { src = plf-src; patches = [ ./increase-latex-itemize-depth.patch ]; };
    vfa = buildPDF { src = vfa-src; };
  }
