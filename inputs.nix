{ config }:

let
  inherit (config) lib;
  pins = import ./npins;

  inputs = {
    nixpkgs = {
      settings = {
        configuration = {
          allowUnfree = true;
        };
      };
    };
  };
in
{
  config = {
    inputs = builtins.mapAttrs (
      name: pin:
      {
        src = pin;
      }
      // (inputs.${name} or { })
      // lib.attrs.when (lib.strings.hasPrefix "plugin-" name) { loader = "raw"; }
    ) (builtins.removeAttrs pins [ "__functor" ]);
  };
}
