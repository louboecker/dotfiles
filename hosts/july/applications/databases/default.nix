{...}: {
  imports = [
    ./mariadb.nix
    ./mongodb.nix
    ./postgres.nix
    ./surrealdb.nix
  ];
}
