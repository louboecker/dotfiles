{ ... }:
{
  services.syncthing = {
    enable = true;
    dataDir = "/home/lou";
    user = "lou";
    group = "users";
    openDefaultPorts = true;

    overrideFolders = false;

    settings = {
      devices = {
        july.id = "DE6GEUO-2DOUV4B-HTNIGKD-VPUA23F-KIRBAX4-3QFKGJY-SMYDK6C-WZU7KAN";
        nothing.id = "YMCGY6V-YUQ2QDU-RJJJIKV-SAYKNCV-64UNWS4-A7RXQSY-KOR26MG-F2AFUQW";
      };
      options = {
        natEnabled = false;
      };
    };
  };
}
