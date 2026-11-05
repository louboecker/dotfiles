{ daniel-bd-puzzle, pkgs, config, self, ... }: {
  age.secrets.basicauth =  {
    file = "${self}/secrets/basicauth.age";
    owner = "nginx";
  };

  services.nginx.virtualHosts."daniel.boecker.dev" = {
    locations."/" = {
      root = daniel-bd-puzzle.packages.${pkgs.system}.default;
      index = "index.html";
      basicAuthFile = config.age.secrets.basicauth.path;
    };
  };
}