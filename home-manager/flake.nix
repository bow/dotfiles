{
  description = "Configuration for home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      unstablePkgs = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    in
    {
      homeConfigurations."bow" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          unstable = unstablePkgs;
        };
      };
      devShells.${system} = {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            nixfmt-rfc-style
            deadnix
            statix
          ];
        };
      };
    };
}
