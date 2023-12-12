# https://github.com/Kattis/problemtools packaged in nix

## Usage

Add as a flake input:
```nix
inputs.problemtools-nix.url = "github:lokegustafsson/problemtools-nix";
```

Include overlay and allow python2 in nixpkgs:
```nix
nixpkgs.overlays = [ problemtools-nix.overlays.default ];
nixpkgs.config.permittedInsecurePackages = [ "python-2.7.18.7" ];
```

Use like a normal package
```nix
... = [ pkgs.problemtools ];
```
