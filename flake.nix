{
  description = "NixOS and nix-darwin configs for my machines";
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Global catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = {
    self,
    catppuccin,
    darwin,
    home-manager,
    nix-homebrew,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Define user configurations
    users = {
      jon = {
        fullName = "Jonathan Schaeffer";
        name = "jon";
        email = "jschaeffer97@gmail.com";
      };
      "jon.schaeffer" = {
        fullName = "Jonathan Schaeffer";
        name = "jon.schaeffer";
        email = "jon.schaeffer@fastly.com";
        username = "jon.schaeffer";
      };
    };

    # Function for NixOS system configuration
    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [./hosts/${hostname}/configuration.nix];
      };

    # Function for nix-darwin system configuration
    mkDarwinConfiguration = hostname: username:
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };

    # Function for Home Manager configuration
    mkHomeConfiguration = system: username: hostname:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;}; 
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
        };
        modules = [
          ./home/${username}/${hostname}.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
  in {
    nixosConfigurations = {
      # empty for now
      # machine = mkNixosConfiguration "machine" "username";
    };

    darwinConfigurations = {
      "dl-mac" = mkDarwinConfiguration "dl-mac" "jon";
      "fast-mac" = mkDarwinConfiguration "fast-mac" "jon.schaeffer";
      "home-mac" = mkDarwinConfiguration "home-mac" "jon";
    };

    homeConfigurations = {
      "jon@dl-mac" = mkHomeConfiguration "aarch64-darwin" "jon" "dl-mac";
      "jon.schaeffer@fast-mac" = mkHomeConfiguration "aarch64-darwin" "jon.schaeffer" "fast-mac";
      "jon@home-mac"  = mkHomeConfiguration "aarch64-darwin" "jon" "home-mac";
    };

    overlays = import ./overlays {inherit inputs;};
  };
}
