{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      july = {
        HostName = "july.boecker.dev";
        User = "emma";
      };
      june = {
        HostName = "june.boecker.dev";
        User = "lou";
      };
      october = {
        HostName = "october.boecker.dev";
        User = "lou";
      };
    };
  };
}
