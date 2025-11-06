{
  project,
  lib,
  pkgs,
  ...
}:

let
  files = builtins.readDir ./plugins;
  directories = lib.filterAttrs (name: type: type == "directory") files;
  names = builtins.attrNames directories;
in
lib.genAttrs names (
  name:
  pkgs.callPackage "${./plugins}/${name}" {
    name = "plugin-${name}";
    inherit project;
  }
)
