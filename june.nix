{ modulesPath, nixpkgs, ... }: {
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/profiles/headless.nix"
    ./hosts/june
    ./common.nix
  ];

  time.timeZone = "Europe/Berlin";

  nix = {
    settings = {
      trusted-users = ["@wheel"];
    };
    registry.nixpkgs.flake = nixpkgs;
    nixPath = [
      "nixpkgs=${nixpkgs}"
    ];
  };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 4*1024;
  } ];

  system.stateVersion = "25.11"; 
}