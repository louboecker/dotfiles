{...}: {
  imports = [
    ./bots
    ./databases
    ./monitoring
    ./matrix.nix
    ./reverse-proxy.nix
    ./immich
    ./media

    ./kanidm.nix

    ./copyparty.nix
    ./railboard-api.nix
    ./rmbg-server.nix

    ./static.nix

    ./minecraft

    ./home
  ];
}
