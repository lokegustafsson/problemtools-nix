{ pkgs ? import <nixpkgs> { } }:
pkgs.python3Packages.buildPythonPackage {
  name = "problemtools";
  src = pkgs.fetchFromGitHub {
    owner = "Kattis";
    repo = "problemtools";
    rev = "v1.20231016";
    fetchSubmodules = true;
    sha256 = "sha256-SyOjXIyfFAg3V4RbbInSfh01gYeF+AIDWn5dtbn/nqw=";
  };
  pyproject = true;
  build-system = [ pkgs.python3Packages.setuptools ];
  doCheck = false;
  propagatedBuildInputs = let p = pkgs;
  in [
    p.boost
    p.gmpxx
    p.pdf2svg
    p.python3Packages.plasTeX
    p.python3Packages.pyyaml
  ];
  nativeBuildInputs = let p = pkgs;
  in [ p.automake p.autoconf (p.writeShellScriptBin "git" "echo $@") ];
  postFixup = let
    pypy3 = pkgs.pypy3.override (y: {
      sqlite = pkgs.sqlite.overrideAttrs
        (x: { configureFlags = x.configureFlags ++ [ "--soname=legacy" ]; });
    });
  in ''
    substituteInPlace $out/lib/python3*/site-packages/problemtools/config/languages.yaml \
      --replace '/usr/bin/gcc ' '${pkgs.lib.meta.getExe pkgs.gcc} ' \
      --replace '/usr/bin/g++ ' '${pkgs.lib.meta.getExe' pkgs.gcc "g++"} ' \
      --replace '/usr/bin/python3 ' '${pkgs.lib.meta.getExe' pypy3 "pypy3"} ' \
      --replace '/usr/bin/rustc ' '${pkgs.lib.meta.getExe pkgs.rustc} ' \
      --replace '-static ' "" \
  '';
  meta.mainProgram = "verifyproblem";
}
