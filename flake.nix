{
  #outputs = { self, nixpkgs }: {
  outputs = { self }: {
    overlays.default = (final: prev: {
      problemtools = import ./default.nix {
        pkgs = prev;
        lib = prev.lib;
      };
    });
    #packages.x86_64-linux.default = import ./default.nix {
    #  pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #  lib = nixpkgs.lib;
    #};
  };
}
