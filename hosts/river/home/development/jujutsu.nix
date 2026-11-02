{ ... }:
{
  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = "Lou Böcker";
        email = "lou@boecker.dev";
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };

      aliases.bump = [
        "bookmark"
        "move"
        "--from"
        "heads(::@- & bookmarks())"
        "--to"
        "@-"
      ];
    };
  };
}
