{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    colmena = {
      url = "github:zhaofengli/colmena";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    iws-rs = {
      url = "github:StckOverflw/iws-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    railboard-api = {
      url = "github:StckOverflw/railboard-api";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    disko,
    lanzaboote,
    nixos-generators,
    agenix,
    home-manager,
    colmena,
    copyparty,
    ...
  } @ attrs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    colmenaHive = colmena.lib.makeHive {
      meta = {
        nixpkgs = import nixpkgs-unstable {
          inherit system;
          overlays = [];
        };
        specialArgs = attrs;
        nodeNixpkgs = {
          july = import nixpkgs {
            inherit system;
            overlays = [
              copyparty.overlays.default
            ];
          };
        };
      };
      july = {
        imports = [
          ./july.nix
          agenix.nixosModules.default
          copyparty.nixosModules.default
        ];
        deployment = {
          targetUser = "emma";
          targetHost = "boecker.dev";
          targetPort = 22;
          buildOnTarget = true;
        };
        nix.registry.nixpkgs.flake = nixpkgs;
      };
      river = {
        imports = [ 
          lanzaboote.nixosModules.lanzaboote
          ./river.nix 
        ];
        nix.registry.nixpkgs.flake = nixpkgs-unstable;
        deployment = {
          allowLocalDeployment = true;
        };
      };
      harper = {
        imports = [
          ./harper.nix
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
        ];
        nix.registry.nixpkgs.flake = nixpkgs-unstable;
        deployment = {
          allowLocalDeployment = true;
        };
      };
    };
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [agenix.packages.x86_64-linux.default colmena.packages.x86_64-linux.colmena];
    };
    formatter.x86_64-linux = pkgs.alejandra;
  };
}
