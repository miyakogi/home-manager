{
  description = "Home Manager configuration of miyaco";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };
    nix-hazkey = {
      url = "github:aster-void/nix-hazkey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-meltype = {
      url = "github:aster-void/nix-meltype";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.meltype-src.url = "github:yksr-melt/Meltype/v1.4.1-pre.2";
    };
    helix = {
      url = "github:helix-editor/helix";
    };
    waybar = {
      url = "github:Alexays/Waybar";
    };
    shaders = {
      url = "github:miyakogi/Anime4K-mpv-glsl";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        # The only unfree packages this configuration uses. Listed
        # explicitly so a newly added unfree dependency fails evaluation
        # instead of being allowed silently.
        config.allowUnfreePredicate =
          p:
          builtins.elem (nixpkgs.lib.getName p) [
            "capacities"
            "lsfg-vk"
            "lsfg-vk-ui"
            "zsh-abbr"
          ];
      };

      # nix-meltype derives systemd.user.sessionVariables from home.sessionVariables,
      # which recurses through Home Manager's opencode module when mutableSettings is
      # enabled. The patch reads the fcitx5 option directly until this is fixed upstream.
      meltypeSrc = pkgs.applyPatches {
        name = "nix-meltype-patched";
        src = inputs.nix-meltype.outPath;
        patches = [ ./patches/nix-meltype-session-vars.patch ];
      };
      meltypeModule = import "${meltypeSrc}/modules/home-manager.nix" (
        meltypePkgs: meltypePkgs.extend inputs.nix-meltype.overlays.default
      );

      # Upstream Waybar copies cava into subprojects/cava-1.0.0, but since
      # f6f73c8 libcava.wrap is a wrap-git without a directory, so meson looks
      # in subprojects/libcava and falls back to downloading (disabled in the
      # Nix sandbox), failing the build.
      waybarPackage = inputs.waybar.packages.${system}.default.overrideAttrs (old: {
        postUnpack =
          pkgs.lib.replaceStrings [ "subprojects/cava-1.0.0" ] [ "subprojects/libcava" ]
            old.postUnpack;
      });
    in
    {
      formatter.${system} = pkgs.nixfmt;

      homeConfigurations."miyaco" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs waybarPackage; };

        modules = [
          meltypeModule
          ./home.nix
        ];
      };
    };
}
