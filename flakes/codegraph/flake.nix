{
  description = "codegraph - Local code intelligence";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.buildNpmPackage {
        pname = "codegraph";
        version = "1.0.1";

        src = pkgs.fetchFromGitHub {
          owner = "colbymchenry";
          repo = "codegraph";
          rev = "b35a292c908a73367a630bc590a69eb2cc881f6a";  # 1.0.1
          hash = "sha256-UsPPDv+0UL5sZNwXGmLdbudbLG4e2RvO6X+uOpuJOyo=";
        };

        postPatch = ''
          cp ${./package.json} ./package.json
          cp ${./package-lock.json} ./package-lock.json
        '';

        npmDeps = pkgs.importNpmLock { npmRoot = ./.; };
        npmConfigHook = pkgs.importNpmLock.npmConfigHook;

        npmBuildScript = "build";

        postInstall = ''
          chmod +x $out/lib/node_modules/@colbymchenry/codegraph/dist/bin/codegraph.js
        '';

        meta = with pkgs.lib; {
          description = "Pre-indexed code knowledge graph for AI agents";
          homepage = "https://github.com/colbymchenry/codegraph";
          license = licenses.mit;
          platforms = platforms.linux;
          mainProgram = "codegraph";
        };
      };
    };
}
