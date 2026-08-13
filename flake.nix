{
  description = "Home Manager configuration of miyaco";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-hazkey = {
      url = "github:aster-void/nix-hazkey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # rio.url = "github:raphamorim/rio/main";
    rio.url = "github:raphamorim/rio/preedit-v2";
    karukan.url = "path:./flakes/karukan";
    waybar.url = "github:Alexays/Waybar";
    shaders = {
      url = "github:miyakogi/Anime4K-mpv-glsl";
      flake = false;
    };
  };


  outputs =
    { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        localSystem = { inherit system; };
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations."miyaco" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
        ];
      };
    };
}
