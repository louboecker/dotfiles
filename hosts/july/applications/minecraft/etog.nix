{ ... }: {
  systemd.tmpfiles.rules = [
    "d /var/lib/minecraft-etog 0755 etog users"
  ];

  users.users.etog = {
    isNormalUser = true;
    extraGroups = [
      
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGzB9z7/VeQvImaojGhoqUnY9qGphmTHpdzXFEkVZk+l"
    ];
  };

  systemd.services.podman-minecraft-etog.serviceConfig.Delegate = "yes";

  virtualisation.oci-containers.containers.minecraft-etog = {
    image = "itzg/minecraft-server:java25";
    pull = "newer";

    environment = {
      EULA="TRUE";
      TYPE="FABRIC";
      VERSION="1.21.10";
      SERVER_PORT = "25565";
      RCON_PORT = "25722";
      MOTD = "";
      SPAWN_PROTECTION="0";
      VIEW_DISTANCE="20";
      SIMULATION_DISTANCE="6";
      DISABLE_HEALTHCHECK = "true";
      MEMORY="8G";
      DIFFICULTY = "hard";
      MODS=''
        https://github.com/Cubxity/UnifiedMetrics/releases/download/v0.3.8/unifiedmetrics-platform-fabric-0.3.8.jar
      '';
      # PLUGINS=''
      #   https://github.com/Cubxity/UnifiedMetrics/releases/download/v0.3.x-SNAPSHOT/unifiedmetrics-platform-bukkit-0.3.10-SNAPSHOT.jar
      #   https://github.com/TCPShield/RealIP/releases/download/2.8.1/TCPShield-2.8.1.jar
      # '';  
      MODRINTH_PROJECTS = ''
        fabric-api
        fabric-language-kotlin
        simple-voice-chat
        spark
        c2me-fabric
        scalablelux
        lithium
        no-chat-reports
      '';
      MODRINTH_ALLOWED_VERSION_TYPE="beta";
      UID="0";
      GID="0";
    };

    user = "0:0";
    podman.user = "etog";

    volumes = [
      "/var/lib/minecraft-etog:/data/"
    ];

    extraOptions = ["--network=host"];
  };

  services.prometheus.scrapeConfigs = [
    {
      job_name = "minecraft";
      static_configs = [
        {
          targets = ["localhost:9100"];
          labels = {
            "server"="etog.boecker.dev";
          };
        }
      ];
    }
  ];

  #  services.nginx.tailscaleAuth = {
  #   enable = true;
  #   virtualHosts = ["lj-map.boecker.dev"]; 
  # };
  # services.nginx.virtualHosts."lj-map.boecker.dev" = {
  #   locations."/" = {
  #     proxyPass = "http://localhost:8100";
  #     proxyWebsockets = true; 
  #   };
  # };
}