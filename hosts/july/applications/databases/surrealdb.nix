{ ... }: {
  services.surrealdb = {
    enable = true;
    port = 8009;
    extraFlags = [
        "--allow-all"
    ];
  };
}