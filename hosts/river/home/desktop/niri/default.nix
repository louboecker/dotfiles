{ pkgs, lib, ... }:
let
  files = [
    "config.kdl"
    "input.kdl"
    "outputs.kdl"
    "layout.kdl"
    "rules.kdl"
    "binds.kdl"
  ];

  niriConfig = pkgs.runCommand "niri-config" { nativeBuildInputs = [ pkgs.niri ]; } ''
    mkdir $out
    grep -v '^spawn-at-startup "waybar"' \
      ${pkgs.niri.src}/resources/default-config.kdl > $out/default-config.kdl
    ${lib.concatMapStrings (f: "cp ${./. + "/${f}"} $out/${f}\n") files}
    niri validate -c $out/config.kdl
  '';
in
{
  # linked file by file so dux shell can write its generated config to ~/.config/niri/dms
  xdg.configFile = lib.genAttrs (map (f: "niri/${f}") ([ "default-config.kdl" ] ++ files)) (name: {
    source = "${niriConfig}/${lib.removePrefix "niri/" name}";
  });

  home.packages = with pkgs; [
    xwayland-satellite
  ];
}
