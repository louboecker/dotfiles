{ pkgs, ... }: {
    systemd.tmpfiles.rules = [
    "d /var/lib/minecraft/tu-info 0775 lou users"
  ];

  networking.firewall.allowedTCPPorts = [
    25541
  ];

  networking.firewall.allowedUDPPorts = [
    25541
    24455
  ];

  virtualisation.oci-containers.containers.tu-info-mc = {
    image = "itzg/minecraft-server:java25";
    pull = "newer";

    environment = {
      EULA="TRUE";
      TYPE="FABRIC";
      VERSION="26.3";
      SERVER_PORT = "25541";
      RCON_PORT = "25866";
      MOTD = "";
      SPAWN_PROTECTION="0";
      VIEW_DISTANCE="32";
      SIMULATION_DISTANCE="8";
      DISABLE_HEALTHCHECK = "true";
      MEMORY="6G";
      MODRINTH_ALLOWED_VERSION_TYPE = "alpha";
      MODRINTH_PROJECTS = ''
        fabric-api
        fabric-language-kotlin
        simple-voice-chat
        spark
        chunky
        c2me-fabric
        scalablelux
        lithium
        no-chat-reports
        enhanced-groups
        no-dim
      '';
    };

    volumes = [
      "/var/lib/minecraft/tu-info:/data/"
    ];

    extraOptions = ["--network=host"];
  };
}