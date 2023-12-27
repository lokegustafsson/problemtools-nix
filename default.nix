{ lib, pkgs }:
let
  plastex = pkgs.python3Packages.buildPythonPackage rec {
    pname = "plasTeX";
    version = "3.0";
    doCheck = false;
    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-YO/LrUdQS+0Ch34JkN3HgsDM68c6jbnPuo/CULwAIlI=";
    };
  };
in pkgs.python3Packages.buildPythonPackage {
  name = "problemtools";
  src = pkgs.fetchFromGitHub {
    owner = "Kattis";
    repo = "problemtools";
    rev = "v1.20231016";
    fetchSubmodules = true;
    sha256 = "sha256-SyOjXIyfFAg3V4RbbInSfh01gYeF+AIDWn5dtbn/nqw=";
  };
  doCheck = false;
  propagatedBuildInputs = let p = pkgs;
  in [ p.gmpxx p.boost p.python3Packages.pyyaml plastex ];
  nativeBuildInputs = let p = pkgs;
  in [ p.automake p.autoconf (p.writeShellScriptBin "git" "echo $@") ];
  postFixup = ''
    substituteInPlace $out/lib/python3*/site-packages/problemtools/config/languages.yaml \
      --replace '/usr/bin/gcc ' '${lib.meta.getExe pkgs.gcc} ' \
      --replace '/usr/bin/g++ ' '${lib.meta.getExe' pkgs.gcc "g++"} ' \
      --replace '/usr/bin/python3 ' '${lib.meta.getExe pkgs.pypy3} ' \
      --replace '-static ' "" \
  '';
  meta.mainProgram = "verifyproblem";
}
