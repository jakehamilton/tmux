{ config }:

{
  config.packages.default = config.packages.neovim;

  config.packages.neovim = {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    package =
      {
        pkgs,
        lib,
        callPackage,
        tmuxPlugins,
        ...
      }:
      let
        plugins = import ./plugins.nix {
          project = config;
          inherit pkgs;
          inherit lib;
        };

        hr =
          text:
          let
            parts = builtins.split "." text;
          in
          builtins.foldl' (text: part: if builtins.isList part then "${text}-" else text) "" (
            builtins.tail parts
          );

        configs = lib.pipe ./config [
          (builtins.readDir)
          (lib.filterAttrs (_name: value: value == "regular"))
          (builtins.attrNames)
          (builtins.map (name: ''
            # ${name}
            # ${hr name}
            ${builtins.readFile "${./config}/${name}"}
          ''))
          (builtins.concatStringsSep "\n")
        ];
      in
      config.inputs.multiplex.result {
        inherit pkgs;

        plugins =
          (with plugins; [
            extrakto
          ])
          ++ (with tmuxPlugins; [
            resurrect
            continuum
            tilish
            tmux-fzf
            vim-tmux-navigator
          ]);

        packages = with pkgs; [
          # Used by tmux-fzf
          gnused
          fzf
        ];

        config = configs;
      };
  };
}
