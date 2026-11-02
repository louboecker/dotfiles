{ pkgs, ... }:
let
  niriConfig = pkgs.runCommand "niri-config" { nativeBuildInputs = [ pkgs.niri ]; } ''
    mkdir $out
    grep -v '^spawn-at-startup "waybar"' \
      ${pkgs.niri.src}/resources/default-config.kdl > $out/default-config.kdl
    cp ${./config.kdl} $out/config.kdl
    cp ${./input.kdl} $out/input.kdl
    cp ${./outputs.kdl} $out/outputs.kdl
    cp ${./layout.kdl} $out/layout.kdl
    cp ${./rules.kdl} $out/rules.kdl
    cp ${./binds.kdl} $out/binds.kdl
    niri validate -c $out/config.kdl
  '';
in
{
  xdg.configFile."niri".source = niriConfig;

  home.packages = with pkgs; [
    xwayland-satellite
  ];
}
