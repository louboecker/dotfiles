{ config, lib, pkgs, ... }:
{
  imports = [
    ../../common.nix
    ./hardware.nix
    ./networking.nix
    ./user.nix
    ./applications
    ./patches
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 2;
    memtest86.enable = true;
  };
  # boot.lanzaboote = {
  #   enable = false;
  #   pkiBundle = "/var/lib/sbctl";
  #   configurationLimit = 2;
  # };

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "river";

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    useXkbConfig = true; 
  };

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
  };

  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  environment.systemPackages = with pkgs; [
    catppuccin-kde
  ];

  services.xserver.xkb.layout = "de";

  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    libva-vdpau-driver
    nvidia-vaapi-driver
    libvdpau-va-gl
  ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    branch = "latest";
  };

  boot.initrd.availableKernelModules = [
    "nvidia_drm" "nvidia_modeset" "nvidia" "nvidia_uvm"
  ];

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };

  system.stateVersion = "25.11"; 
}