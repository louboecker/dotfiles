{ ... }:
{
  programs.kitty = {
    enable = true;

    shellIntegration.mode = null;

    settings = {
      shell_integration = "enabled";
      font_size = "12.0";

      window_padding_width = 12;
      background_opacity = "1.0";
      background_blur = 32;
      hide_window_decorations = "yes";
      remember_window_size = "no";

      cursor_shape = "block";
      cursor_blink_interval = 1;

      scrollback_lines = 3000;

      copy_on_select = "yes";
      strip_trailing_spaces = "smart";

      tab_bar_style = "powerline";
      tab_bar_align = "left";
    };

    keybindings = {
      "ctrl+shift+n" = "new_window";
      "ctrl+t" = "new_tab";
      "ctrl+plus" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
      "ctrl+0" = "change_font_size all 0";
    };

    extraConfig = ''
      include themes/noctalia.conf
    '';
  };
}
