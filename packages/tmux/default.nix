{ lib
, pkgs
, tmux-config ? import ./default-config.nix { inherit lib pkgs; }
, ...
}:

pkgs.tmux.overrideAttrs (oldAttrs: {
  buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ pkgs.makeWrapper ];

  postInstall = (oldAttrs.postInstall or "") + ''
    mkdir $out/libexec

    mv $out/bin/tmux $out/libexec/tmux-unwrapped

    makeWrapper $out/libexec/tmux-unwrapped $out/bin/tmux \
      --add-flags "-f ${tmux-config}"
  '';
})
