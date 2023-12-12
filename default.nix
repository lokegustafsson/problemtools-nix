{ lib, pkgs }:
let
  pyyaml = pkgs.python2Packages.buildPythonPackage rec {
    pname = "PyYAML";
    version = "3.12";
    src = pkgs.python2Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-WSdmxjAyB6IO/ERVh3eDItf3OxYb2ZTyJ62qNBuiEqs=";
    };
  };
  plastex = pkgs.python2Packages.buildPythonPackage rec {
    pname = "plasTeX";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "plastex";
      repo = "plastex";
      rev = "1.0.0";
      sha256 = "sha256-82aMQ2915PWT82BL8u3kRf2rbakqsoOtyOMyO5UQY6w=";
    };
  };
  six = pkgs.python2Packages.buildPythonPackage rec {
    pname = "six";
    version = "1.16.0";
    src = pkgs.python2Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-HmHDdHehYmRY4297HYKqXJsJT6SAKJIHLknenGDEySY=";
    };
    doCheck = false;
  };
in pkgs.python2Packages.buildPythonPackage {
  name = "problemtools";
  src = pkgs.fetchgit {
    url = "https://github.com/Kattis/problemtools.git";
    rev = "v1.20191126";
    sha256 = "sha256-ekNrfEf98WJWb5nzUVJe6fcsCPOhVKVrwahN124FVMI=";
    fetchSubmodules = true;
    leaveDotGit = true;
  };
  doCheck = false;
  propagatedBuildInputs = let p = pkgs;
  in [ p.gmpxx p.boost pyyaml plastex six ];
  nativeBuildInputs = let p = pkgs; in [ p.git p.automake p.autoconf ];
  postFixup = ''
    substituteInPlace $out/lib/python2.7/site-packages/problemtools/config/languages.yaml \
      --replace '/usr/bin/gcc ' '${lib.meta.getExe pkgs.gcc} ' \
      --replace '/usr/bin/g++ ' '${lib.meta.getExe' pkgs.gcc "g++"} ' \
      --replace '/usr/bin/python3 ' '${lib.meta.getExe pkgs.pypy3} ' \
      --replace '-static ' "" \
  '';
  meta.mainProgram = "verifyproblem";
}
