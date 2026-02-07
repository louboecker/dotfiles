{ pkgs, ... }: {
  nix.package = pkgs.lixPackageSets.latest.lix; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}