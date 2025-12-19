{ ... }: {
  systemd.tmpfiles.rules = [
    "d /var/lib/tweakistan 0755 valle users"
  ];

  users.users.valle = {
    isNormalUser = true;
    linger = true;
    extraGroups = [
      
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQMSHWPTtZ7CM2yv0Feo3mtI8xGUPLJywKE1NRScvLQ"
    ];
  };

  systemd.services.podman-tweakistan.serviceConfig.Delegate = "yes";

  networking.firewall.allowedTCPPorts = [
    25566
  ];

  networking.firewall.allowedUDPPorts = [
    25566
    24455
  ];

  virtualisation.oci-containers.containers.tweakistan = {
    image = "itzg/minecraft-server:java25";
    pull = "newer";

    environment = {
      EULA="TRUE";
      TYPE="FABRIC";
      VERSION="1.21.10";
      SERVER_PORT = "25566";
      RCON_PORT = "25766";
      MOTD = "";
      SPAWN_PROTECTION="0";
      VIEW_DISTANCE="22";
      SIMULATION_DISTANCE="6";
      DISABLE_HEALTHCHECK = "true";
      ICON="https://static.boecker.dev/chicken_jockey.jpeg";
      MEMORY="6G";
      # PLUGINS=''
      #   https://github.com/Cubxity/UnifiedMetrics/releases/download/v0.3.x-SNAPSHOT/unifiedmetrics-platform-bukkit-0.3.10-SNAPSHOT.jar
      #   https://static.boecker.dev/CoreProtect-23.0.jar
      #   https://static.boecker.dev/kommunismus-1.0.0.jar
      # '';  
      # MODRINTH_PROJECTS = ''
      #   simple-voice-chat
      #   chunky
      # '';
      MODS= '' 
        https://github.com/Cubxity/UnifiedMetrics/releases/download/v0.3.x-SNAPSHOT/unifiedmetrics-platform-fabric-0.3.10-SNAPSHOT.jar
      '';
      MODRINTH_PROJECTS = ''
        fabric-api
        fabric-language-kotlin
        simple-voice-chat
        bluemap
        spark
        chunky
        c2me-fabric
        scalablelux
        lithium
        no-chat-reports
        no-dim
        invview
        vanish
        enhanced-groups
      '';
      MODRINTH_ALLOWED_VERSION_TYPE="alpha";
      UID="0";
      GID="0";
    };

    user = "0:0";
    podman.user = "valle";

    volumes = [
      "/var/lib/tweakistan:/data/"
    ];

    extraOptions = ["--network=host"];
  };

  services.prometheus.scrapeConfigs = [
    {
      job_name = "tweakistan";
      static_configs = [
        {
          targets = ["localhost:9101"];
          labels = {
            "server"="tweakistan.boecker.dev";
          };
        }
      ];
    }
  ];

  services.nginx.virtualHosts."tweakistan.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://localhost:8101";
      proxyWebsockets = true; 
    };
  };

  services.nginx.virtualHosts."tweakistan.curllz.com" = {
    locations."/" = {
      proxyPass = "http://localhost:8101";
      proxyWebsockets = true; 
    };
  };
}