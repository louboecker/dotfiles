{ ... }:
{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      shell = {
        polkit_agent = true;
        niri_overview_close_on_launch_enabled = true;
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
        templates.builtin_ids = [ "kitty" ];
      };

      backdrop.enabled = true;

      bar.default = {
        widget_spacing = 12;
        margin_ends = 0;
      };
    };
  };
}
