{
  config,
  lib,
  pkgs,
  dms-plugin-registry,
  ...
}:
{
  imports = [
    dms-plugin-registry.nixosModules.default
    ../../common.nix
    ./hardware.nix
    ./networking.nix
    ./user.nix
    ./desktop.nix
    ./applications
    ./patches
  ];

  # boot.loader.systemd-boot = {
  #   enable = true;
  #   configurationLimit = 2;
  #   memtest86.enable = true;
  # };
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    configurationLimit = 10;
  };

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
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

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
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia"
    "nvidia_uvm"
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
