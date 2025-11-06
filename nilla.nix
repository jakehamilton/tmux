let
  pins = import ./npins;

  nilla = import pins.nilla;
in
nilla.create {
  includes = [
    ./inputs.nix
    ./package.nix
  ];
}
