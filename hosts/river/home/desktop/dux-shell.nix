{ dux-shell, dms-plugin-registry, ... }:
{
  imports = [
    dux-shell.homeModules.dank-material-shell
    dms-plugin-registry.homeModules.default
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    plugins.dankKDEConnect.enable = true;
  };
}
