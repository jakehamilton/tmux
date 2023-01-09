{
  description = "My Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable.url = "github:nixos/nixpkgs";

    snowfall = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall.mkFlake {
      inherit inputs;
      src = ./.;

      overlay-package-namespace = "plusultra";

      alias.packages.default = "tmux";
    };
}
