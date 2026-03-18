{ ... }: {
  
  systemd.tmpfiles.rules = [
    "d /var/lib/mistserver 0755 emma users"
    "d /var/lib/mistserver/video 0755 emma users"
  ];

  networking.firewall.allowedTCPPorts = [
    1935
  ];

  networking.firewall.allowedUDPPorts = [
    1935
  ];

  virtualisation.oci-containers.containers.mistserver = {
    image = "ddvtech/mistserver";
    pull = "newer";

    environment = {
    }; 

    volumes = [
      "/var/lib/mistserver/config.json:/config.json"
      "/var/lib/mistserver/video:/video"
    ];

    extraOptions = ["--network=host"];
  };

  services.nginx.virtualHosts."stream.boecker.dev".locations."/" = {
    proxyPass = "http://127.0.0.1:4242";
    proxyWebsockets = true;
  };
}