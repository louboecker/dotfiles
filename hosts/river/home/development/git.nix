{ ... }:
{
  programs.git = {
    enable = true;

    settings.user = {
      name = "Lou Böcker";
      email = "lou@boecker.dev";
    };

    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
}
