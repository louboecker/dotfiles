{...}: {
  imports = [
    ./mariadb.nix
    ./mongodb.nix
    ./postgres.nix
    ./redis-authentik.nix
    ./surrealdb.nix
  ];
}
