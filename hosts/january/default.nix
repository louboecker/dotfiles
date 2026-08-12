{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware.nix
      ./user.nix
      ./tailscale.nix
      ./applications
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "january";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };

  networking.hostId = "bc107e87";
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
  };

  services.xserver.xkb.layout = "de";

  services.openssh.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  services.acpid = {
    enable = true;
    lidEventCommands = ''
      case "$(cat /proc/acpi/button/lid/LID0/state)" in
        *closed*) echo 4 > /sys/class/backlight/*/bl_power ;;
        *open*)   echo 0 > /sys/class/backlight/*/bl_power ;;
      esac
    '';
  };

  system.stateVersion = "26.11"; 

}
