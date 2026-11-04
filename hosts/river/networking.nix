{ pkgs, ... }: {
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [ networkmanager-openconnect ];
  networking.firewall.enable = false;

  networking = {
    interfaces = {
      eno1 = {
        wakeOnLan.enable = true;
      };
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}
