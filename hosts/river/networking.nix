{...}: {
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}