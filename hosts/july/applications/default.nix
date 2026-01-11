{...}: {
  imports = [
    ./bots
    ./databases
    ./monitoring
    ./matrix.nix
    ./reverse-proxy.nix
    ./immich

    ./kanidm.nix

    ./nextcloud.nix
    ./railboard-api.nix
    ./rmbg-server.nix

    ./static.nix

    ./minecraft

    ./home
  ];
}
