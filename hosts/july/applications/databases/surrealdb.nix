{ ... }: {
  services.surrealdb = {
    enable = false;
    port = 8009;
    extraFlags = [
        "--allow-all"
    ];
  };
}