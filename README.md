# https://github.com/Kattis/problemtools packaged in nix

## Usage

Add as a flake input:
```nix
inputs.problemtools-nix.url = "github:lokegustafsson/problemtools-nix";
```
```nix
outputs = { .. problemtools-nix .. }: ..
```

Include overlay in nixpkgs:
```nix
nixpkgs.overlays = [ problemtools-nix.overlays.default ];
```

Use like a normal package
```nix
... = [ pkgs.problemtools ];
```
