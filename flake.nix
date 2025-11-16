{
    description = "ludihan nix config :^)";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ { nixpkgs, home-manager, ... } :
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            nixosConfigurations = {
                nixos = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs;};

                    modules = [./nixos/configuration.nix];

                };
            };

            homeConfigurations = {
                "ludihan" = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;

                    extraSpecialArgs = {inherit inputs;};

                    modules = [./home-manager/home.nix];

                };
            };
        };
}
