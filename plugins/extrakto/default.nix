{
  name,
  project,
  pkgs,
  lib,
  tmuxPlugins,
  ...
}:

tmuxPlugins.mkTmuxPlugin {
  pluginName = lib.removePrefix "plugin-" name;
  version = "";

  src = project.inputs.${name}.result;

  meta = {
    homepage = "https://github.com/laktak/extrakto";
    description = "Fuzzy find your text with fzf instead of selecting it by hand ";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  postInstall = ''
    for f in extrakto.sh; do
      chmod +x $target/scripts/$f
      wrapProgram $target/scripts/$f \
        --prefix PATH : ${
          with pkgs;
          lib.makeBinPath (
            [
              pkgs.fzf
              pkgs.python3
            ]
            ++ (lib.optionals pkgs.stdenv.isLinux (
              with pkgs;
              [
                xclip
                wl-clipboard
              ]
            ))
          )
        }
    done
  '';
}
