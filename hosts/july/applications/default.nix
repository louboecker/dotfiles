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
    
    ./files
    ./railboard-api.nix
    ./rmbg-server.nix
    
    ./reposilite.nix

    ./streaming

    ./static.nix

    ./minecraft

    ./home
  ];
}
