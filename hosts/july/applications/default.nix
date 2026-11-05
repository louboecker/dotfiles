{...}: {
  imports = [
    ./bots
    ./databases
    ./monitoring
    ./matrix.nix
    ./reverse-proxy.nix
    ./http-tunnel.nix
    ./immich
    ./media

    ./kanidm.nix
    ./vaultwarden.nix
    ./ntfy.nix
    
    ./files
    ./railboard-api.nix
    ./bvb-alert.nix
    ./daniel-bd-puzzle.nix
    ./rmbg-server.nix
    
    ./reposilite.nix
    ./forgejo.nix

    ./streaming

    ./static.nix

    ./minecraft

    ./home
  ];
}
