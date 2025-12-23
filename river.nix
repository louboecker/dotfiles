{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hosts/river
      ./common.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "river";

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; 
  };

  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  services.system76-scheduler.enable = true;

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
  ];

  services.xserver.xkb.layout = "de";

  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };

  system.stateVersion = "25.11"; 
}

