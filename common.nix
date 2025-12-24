{ pkgs, ... }: {
  nix.package = pkgs.lixPackageSets.latest.lix; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}