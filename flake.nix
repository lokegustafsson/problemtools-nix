{
  outputs = { self }: {
    overlays.default = (final: prev: {
      problemtools = import ./default.nix {
        pkgs = prev;
        lib = prev.lib;
      };
    });
  };
}
