{ ... }: {
  imports = [
    ./jellyfin.nix
    ./oauth-proxy.nix
    ./bazarr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./bitmagnet.nix
    ./transmission.nix
    ./vpn.nix
  ];

  users = {
    users.media = {
      isSystemUser = true;
      group = "media";
    };
    groups.media = { };
    users.emma.extraGroups = [ "media" ];
  };
}