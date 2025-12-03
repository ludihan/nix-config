{
  description = "ludihan nix config :^)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    templates.url = "github:nixos/templates";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      templates,
      home-manager,
      nix-index-database,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        #nixos = nixpkgs.lib.nixosSystem {
        #    specialArgs = {inherit inputs;};

        #    modules = [./nixos/configuration.nix];

        #};
        nixos-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/desktop
          ];

        };
        nixos-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/laptop
          ];

        };
      };

      homeConfigurations = {
        "ludihan@nixos-desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = { inherit inputs; };

          modules = [
            ./hosts/desktop/home.nix
            nix-index-database.homeModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
          ];
        };
        "ludihan@nixos-laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = { inherit inputs; };

          modules = [
            ./hosts/laptop/home.nix
            nix-index-database.homeModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
          ];
        };
      };
      inherit templates;
    };
}
